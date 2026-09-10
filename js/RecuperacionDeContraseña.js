/* =========================================================
   RECUPERACIÓN DE CONTRASEÑA — ZONA HUELLA
   =========================================================
   Este archivo envía un correo real usando EmailJS
   (https://www.emailjs.com), porque un sitio 100% front-end
   (sin servidor propio) no puede enviar correos por sí mismo.

   PASOS PARA QUE EL ENVÍO DE CORREO FUNCIONE:
   1. Crea una cuenta gratuita en https://www.emailjs.com
   2. Conecta un servicio de correo (puede ser tu propio Gmail)
      en "Email Services" -> copia el SERVICE_ID.
   3. Crea una plantilla en "Email Templates" con al menos las
      variables {{to_email}} y {{reset_link}} -> copia el
      TEMPLATE_ID.
   4. En "Account" -> "General" copia tu PUBLIC_KEY.
   5. Reemplaza las 3 constantes de abajo con esos valores.
   ========================================================= */

const EMAILJS_PUBLIC_KEY  = "TU_PUBLIC_KEY";
const EMAILJS_SERVICE_ID  = "TU_SERVICE_ID";
const EMAILJS_TEMPLATE_ID = "TU_TEMPLATE_ID";

// Clave de localStorage donde Register.js guarda a los usuarios
const USERS_STORAGE_KEY = "usuarios";

// Cuánto dura vigente el enlace de recuperación (30 minutos)
const RESET_LINK_TTL_MS = 30 * 60 * 1000;

document.addEventListener("DOMContentLoaded", () => {

    if (window.emailjs && EMAILJS_PUBLIC_KEY !== "TU_PUBLIC_KEY") {
        emailjs.init({ publicKey: EMAILJS_PUBLIC_KEY });
    }

    const form         = document.getElementById("recoveryForm");
    const emailInput   = document.getElementById("recoveryEmail");
    const errorLabel   = document.getElementById("recoveryError");
    const successBox   = document.getElementById("recoverySuccess");
    const submitBtn    = document.getElementById("btn-submit-recovery");
    const btnText      = submitBtn.querySelector(".btn-text");
    const btnSpinner   = submitBtn.querySelector(".btn-spinner");

    form.addEventListener("submit", (event) => {
        event.preventDefault();
        handleRecoverySubmit();
    });

    emailInput.addEventListener("input", () => clearError());

    async function handleRecoverySubmit() {
        const email = emailInput.value.trim().toLowerCase();

        if (!isValidGmail(email)) {
            showError("Escribe un correo de Gmail válido (ejemplo@gmail.com).");
            return;
        }

        setLoading(true);

        try {
            const resetLink = buildResetLink(email);

            // Solo intenta enviar el correo si ya se configuraron las
            // credenciales de EmailJS; si no, se simula el envío para
            // que puedas seguir probando el flujo visual mientras tanto.
            if (window.emailjs && EMAILJS_PUBLIC_KEY !== "TU_PUBLIC_KEY") {
                await emailjs.send(EMAILJS_SERVICE_ID, EMAILJS_TEMPLATE_ID, {
                    to_email: email,
                    reset_link: resetLink
                });
            } else {
                console.warn(
                    "EmailJS no está configurado todavía: revisa las constantes " +
                    "EMAILJS_PUBLIC_KEY, EMAILJS_SERVICE_ID y EMAILJS_TEMPLATE_ID " +
                    "en RecuperacionDeContraseña.js. Enlace generado:",
                    resetLink
                );
            }

            showSuccess();
            form.reset();

        } catch (error) {
            console.error("Error al enviar el correo de recuperación:", error);
            showError("No pudimos enviar el correo. Intenta de nuevo en unos minutos.");

        } finally {
            setLoading(false);
        }
    }

    function isValidGmail(email) {
        return /^[^\s@]+@gmail\.com$/.test(email);
    }

    // Genera un token de un solo uso y lo guarda junto con su fecha
    // de expiración, para que la página que recibe el enlace
    // (RestablecerContraseña.html) pueda validarlo más adelante.
    function buildResetLink(email) {
        const token = crypto.randomUUID
            ? crypto.randomUUID()
            : Date.now().toString(36) + Math.random().toString(36).slice(2);

        const resetRequests = JSON.parse(localStorage.getItem("resetRequests") || "{}");
        resetRequests[token] = {
            email,
            expiresAt: Date.now() + RESET_LINK_TTL_MS
        };
        localStorage.setItem("resetRequests", JSON.stringify(resetRequests));

        const baseUrl = window.location.href.replace(/RecuperacionDeContraseña\.html.*$/, "");
        return `${baseUrl}RestablecerContraseña.html?token=${token}`;
    }

    function showError(message) {
        errorLabel.textContent = message;
        emailInput.classList.add("is-invalid");
        successBox.classList.add("d-none");
    }

    function clearError() {
        errorLabel.textContent = "";
        emailInput.classList.remove("is-invalid");
    }

    function showSuccess() {
        clearError();
        successBox.classList.remove("d-none");
    }

    function setLoading(isLoading) {
        submitBtn.disabled = isLoading;
        btnText.classList.toggle("d-none", isLoading);
        btnSpinner.classList.toggle("d-none", !isLoading);
    }

});