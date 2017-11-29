$(document).ready(function() {
    $('#sign-in').formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            name: {
                validators: {
                    notEmpty: {
                        message: 'Your name is required'
                    }
                }
            },
            username: {
                validators: {
                    notEmpty: {
                        message: 'Your username is required'
                    },
                    stringLength: {
                      min: 6,
                      max: 20,
                      message: 'Your username must be between 6 and 20 characters long'
                    }
                }
            },
            email: {
              validators: {
                notEmpty: {
                  message: 'An email address is required'
                },
                emailAddress: {
                  message: 'Please enter a valid email address'
                }
              }
            },
            password: {
                validators: {
                    notEmpty: {
                        message: 'Password is required'
                    },
                    stringLength: {
                        min: 6,
                        message: 'Password must be atleast 6 characters long'
                    }
                }
            },
            bio: {
                validators: {
                    notEmpty: {
                        message: 'Please tell us about yourself!'
                    }
                }
            },
            profession: {
                validators: {
                    notEmpty: {
                        message: 'We need to know your profession!'
                    }
                }
            },
            sex: {
                validators: {
                    notEmpty: {
                        message: 'Please select your gender, or specify that you would rather not'
                    }
                }
            },
            howYouHeard: {
                validators: {
                    notEmpty: {
                        message: 'Please tell us how you heard about us'
                    }
                }
            }
        }
    });
});
