var FlashMessages = function () {
  this.$container = $('#flash-messages');
};

FlashMessages.prototype.pop = function (message) {
  this.$container.html(message);
};

FlashMessages.prototype.success = function (message) {
  this.pop("<div class='alert alert-success'><i class='fa-fw fa fa-check'></i><strong>"+message+"</strong></div>");
};

FlashMessages.prototype.error = function (message) {
  this.pop("<div class='alert alert-danger'><i class='fa-fw fa fa-times'></i><strong>"+message+"</strong></div>");
};