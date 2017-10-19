$(function () {
    var CONTACT_COMPLETE_PARAMETER = "?contact_complete";

    function showContactCompleteMessage() {
        getContactCompleteMessageObject().show();
    }

    function getContactCompleteMessageObject() {
        return $('#contact_complete_message');
    }

    function isContactCompleteUrl() {
        return isContainString(getCurrentUrl(), CONTACT_COMPLETE_PARAMETER)
    }

    function isContainString(check_string, target_string) {
        return check_string.indexOf(target_string) !== -1;
    }

    function getCurrentUrl() {
        return window.location.href;
    }

    function executeMain() {
        if (isContactCompleteUrl()) {
            showContactCompleteMessage();
        }
    }

    executeMain();
});