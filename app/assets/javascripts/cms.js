$(document).ready(function () {

    String.prototype.format = function () {
        var formatted = this;
        for (arg in arguments) {
            formatted = formatted.replace("{" + arg + "}", arguments[arg]);
        }
        return formatted;
    };

    var authParams = {'api_key':getUrlVars()["api_key"]};
    var doseUnits = [
        "mg",
        "mg/kg",
        "mg/kg/hour",
        "mcg",
        "g",
        "mL",
        "L",
        "capsules",
        "tablets",
        "drops",
        "%",
        "IU",
        "Cream",
        "Gel",
        "Patch",
        "Puffs",
        "Sprays",
        "Scoops",
        "units/kg",
        "units/kg/hour",
        "CC",
        "C",
        "X"
    ];
    var frequencyUnits = [
        "x/day",
        "x/week",
        "x/month",
        "x/year",
        "x/hour",
        "prn"
    ];
    var durationUnits = [
        "days",
        "hours",
        "weeks",
        "months",
        "years",
        "prn",
        "ongoing"
    ];

    var routeUnits = [
        "AURICULAR (OTIC)",
        "BUCCAL",
        "CONJUNCTIVAL",
        "CUTANEOUS",
        "DENTAL",
        "ENDOSINUSIAL",
        "ENDOTRACHEAL",
        "ENTERAL",
        "EPIDURAL",
        "EXTRACORPOREAL",
        "INFILTRATION",
        "INTERSTITIAL",
        "INTRA-ARTERIAL",
        "INTRA-ARTICULAR",
        "INTRABRONCHIAL",
        "INTRABURSAL",
        "INTRACARDIAC",
        "INTRACAUDAL",
        "INTRACAVERNOUS",
        "INTRACAVITARY",
        "INTRADERMAL",
        "INTRAGASTRIC",
        "INTRAGINGIVAL",
        "INTRALESIONAL",
        "INTRAMUSCULAR",
        "INTRAOCULAR",
        "INTRAPERITONEAL",
        "INTRAPLEURAL",
        "INTRASPINAL",
        "INTRASYNOVIAL",
        "INTRATHECAL",
        "INTRAUTERINE",
        "INTRAVASCULAR",
        "INTRAVENOUS",
        "INTRAVENTRICULAR",
        "INTRAVESICAL",
        "INTRAVITREAL",
        "IRRIGATION",
        "LARYNGEAL",
        "NASAL",
        "NASOGASTRIC",
        "NOT APPLICABLE",
        "OCCLUSIVE DRESSING TECHNIQUE",
        "OPHTHALMIC",
        "ORAL",
        "OROPHARYNGEAL",
        "PARENTERAL",
        "PERCUTANEOUS",
        "PERINEURAL",
        "PERIODONTAL",
        "RECTAL",
        "RESPIRATORY (INHALATION)",
        "RETROBULBAR",
        "SOFT TISSUE",
        "SUBARACHNOID",
        "SUBCONJUNCTIVAL",
        "SUBCUTANEOUS",
        "SUBGINGIVAL",
        "SUBLINGUAL",
        "SUBMUCOSAL",
        "TOPICAL",
        "TRANSDERMAL",
        "TRANSMUCOSAL",
        "TRANSTRACHEAL",
        "URETERAL",
        "URETHRAL",
        "VAGINAL",
        "EXTRACORPOREAL",
        "INTERSTITIAL",
        "INTRA-ARTICULAR",
        "INTRAPERITONEAL",
        "INTRAPLEURAL",
        "INTRA-ARTERIAL"
    ]

    var disorderCui = null;
    var treatmentCui = null;
    var cachePrescriptions = null;
    var lastRequest = null;

    function getUrlVars() {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    }

    $('.edit-treatment-search').live('keydown',function (e) {
        var keyCode = e.keyCode || e.which;

        if (keyCode == 9 || keyCode == 13) {
            $(this).parent().removeClass('open');
            $(this).data('cui', "");
            // call custom function here
        }
    });

    var setupEditTreatmentSearchResult = function () {
        $('.edit-treatment-search-result').unbind();
        $('.edit-treatment-search-result').click(function () {
            var table = $(this).parents('.edit-treatment-search-results');
            table.parent().removeClass('open');
            var inputField = table.parent().children('.edit-treatment-search');
            inputField.val($(this).html());
            inputField.data('cui', $(this).data('cui'));
            table.empty();
        });
    };

    var setupEditTreatmentSearch = function () {
        // $('#treatment-search').focus(function() {
        //   if ($('#treatment-search-results').children().length !== 0) {
        //     $('#treatment-search-dropdown-container').addClass('open');
        //   }
        // }).blur(function() {
        //   if ($('#treatment-search-results').children().length === 0) {
        //     $('#treatment-search-dropdown-container').removeClass('open');
        //   }
        // });

        $('.dose-label-input').unbind().focus(function () {
            var input = $(this);
            var dropdown = $(this).parent().children('.dropdown-menu');
            var html = ""
            $.each(doseUnits, function (idx, doseUnit) {
                html += '<tr><td>' + doseUnit + '</td></tr>';
            });
            dropdown.html(html);
            dropdown.find('td').click(function () {
                input.val($(this).text());
            });
            $(this).parents('.dropdown').addClass('open');
        }).blur(function () {
                var input = $(this);
                setTimeout(function () {
                    input.parents('.dropdown').removeClass('open');
                }, 500);
            });

        $('.frequency-label-input').unbind().focus(function () {
            var input = $(this);
            var dropdown = $(this).parent().children('.dropdown-menu');
            var html = ""
            $.each(frequencyUnits, function (idx, doseUnit) {
                html += '<tr><td>' + doseUnit + '</td></tr>';
            });
            dropdown.html(html);
            dropdown.find('td').click(function () {
                input.val($(this).text());
            });
            $(this).parents('.dropdown').addClass('open');
        }).blur(function () {
                var input = $(this);
                setTimeout(function () {
                    input.parents('.dropdown').removeClass('open');
                }, 500);
            });

        $('.duration-label-input').unbind().focus(function () {
            var input = $(this);
            var dropdown = $(this).parent().children('.dropdown-menu');
            var html = ""
            $.each(durationUnits, function (idx, doseUnit) {
                html += '<tr><td>' + doseUnit + '</td></tr>';
            });
            dropdown.html(html);
            dropdown.find('td').click(function () {
                input.val($(this).text());
            });
            $(this).parents('.dropdown').addClass('open');
        }).blur(function () {
                var input = $(this);
                setTimeout(function () {
                    input.parents('.dropdown').removeClass('open');
                }, 500);
            });

        $('.route-label-input').unbind().focus(function () {
            var input = $(this);
            var dropdown = $(this).parent().children('.dropdown-menu');
            var html = ""
            $.each(routeUnits, function (idx, route) {
                html += '<tr><td>' + route + '</td></tr>';
            });
            dropdown.html(html);
            dropdown.find('td').click(function () {
                input.val($(this).text());
            });
            $(this).parents('.dropdown').addClass('open');
        }).blur(function () {
                var input = $(this);
                setTimeout(function () {
                    input.parents('.dropdown').removeClass('open');
                }, 500);
            });

        $('.remove-signature').unbind().click(function () {
            $(this).parents('.edit-prescription-row').remove();
        });

        $('.edit-treatment-search').unbind().on('input', function () {
            if (lastRequest) {
                lastRequest.abort();
            }

            var searchResultsTable = $(this).parent().children('.edit-treatment-search-results');
            searchResultsTable.empty();

            if ($(this).val() === "") {
                searchResultsTable.empty();
                $(this).parent().removeClass('open');
            } else {
                $(this).parent().addClass('open');
                var params = jQuery.extend({}, authParams);
                params['q'] = $(this).val();
                lastRequest = $.getJSON('/treatments/search', params, function (data) {
                    lastRequest = null;

                    var treatments = data['results'];
                    var items = [];
                    $.each(treatments, function (idx, treatment) {
                        items.push('<tr><td data-cui="' + treatment['code'] + '" class="edit-treatment-search-result">' + treatment['label'] + '</td></tr>');
                    });

                    searchResultsTable.html(items.join(''));

                    setupEditTreatmentSearchResult();
                });
            }
        });
    };

    var newSignatureRow = '<tr class="edit-prescription-row">'+
                          '<td class="edit-prescription-cell">'+
                          '<label class="close remove-signature">&times;</label>'+
                          '<label>Treatment name</label>'+
                          '<div class="dropdown"><input type="text" class="edit-treatment-search">'+
                          '<table class="table table-hover dropdown-menu edit-treatment-search-results"></table>'+
                          '</div>'+
                          '<div class="brand-name">'+
                          '<label>Brand name</label>'+
                          '<input type="text" placeholder="Enter for free input only" class="brand-input">'+
                          '</div>'+
                          '<label>Dose</label>'+
                          '<div class="control-group"><div class="controls"><div class="dropdown">'+
                          '<input type="text" class="span1 dose-input">'+
                          '<input type="text" class="span1 dose-high-input">'+
                          '<input type="text" class="span2 dose-label-input" value="mg">'+
                          '<table class="table table-hover dropdown-menu"></table>'+
                          '</div></div></div>'+
                          '<label>Frequency</label>'+
                          '<div class="control-group"><div class="controls"><div class="dropdown">'+
                          '<input type="text" class="span1 frequency-input">'+
                          '<input type="text" class="span1 frequency-high-input">'+
                          '<input type="text" class="span2 frequency-label-input" value="x/day">'+
                          '<table class="table table-hover dropdown-menu"></table>'+
                          '</div></div></div>'+
                          '<label>Duration</label>'+
                          '<div class="control-group"><div class="controls"><div class="dropdown">'+
                          '<input type="text" class="span1 duration-input">'+
                          '<input type="text" class="span1 duration-high-input">'+
                          '<input type="text" class="span2 duration-label-input" value="days">'+
                          '<label>Route</label>'+
                          '<input type="text" class="span2 route-label-input" value="ORAL">'+
                          '<table class="table table-hover dropdown-menu"></table>'+
                          '</div></div></div></td></tr>';

    var setupEditPrescriptionActions = function () {
        $('#combine-with-button').click(function () {
            $('#edit-submit-tray').before(newSignatureRow);
            setupEditTreatmentSearch();
        });
        $('#save-changes').click(function () {
            var prescriptionId = '';
            $(this).after($("#loading-img").clone().removeClass("hidden").attr("id", null).addClass("loading"));
            var doSubmit = function (idx, elem) {
                var params = jQuery.extend({}, authParams);

                if (prescriptionId) {
                    params['rx_id'] = prescriptionId;
                }
                params['rx_cui'] = elem.find('.edit-treatment-search').data('cui');
                params['rx_name'] = elem.find('.edit-treatment-search').val();
                params['brand'] = elem.find('.brand-input').val();
                params['dose'] = elem.find('.dose-input').val();
                params['dose_high'] = elem.find('.dose-high-input').val();
                params['dose_unit'] = elem.find('.dose-label-input').val();
                params['frequency'] = elem.find('.frequency-input').val();
                params['frequency_high'] = elem.find('.frequency-high-input').val();
                params['frequency_unit'] = elem.find('.frequency-label-input').val();
                params['duration'] = elem.find('.duration-input').val();
                params['duration_high'] = elem.find('.duration-high-input').val();
                params['duration_unit'] = elem.find('.duration-label-input').val();
                params['route'] = elem.find('.route-label-input').val();
                params['dx_code'] = disorderCui;
                params['note'] = $('#prescription-note').val();

                $.post('/prescriptions/', params, function (data) {
                    results = data['results'];
                    prescriptionId = results[0]['id'];
                    if (idx + 1 == $('.edit-prescription-cell').length) {
                        $(".loading").remove();
                        cachePrescriptions = null;
                        $('.disorder-search-result-row.info').children().click();
                        $('#add-prescription-button').click();
                    } else {
                        doSubmit(idx + 1, elem.parent().next().children());
                    }
                });
            };
            doSubmit(0, $('.edit-prescription-cell').first());
        });
    };

    // var setupEditPrescription = function() {
    //   $('.prescription').click(function() {
    //     $('.prescription-row').removeClass('info');
    //     $(this).parent().addClass('info');
    //     $('#edit-prescription').empty();

    //     var selectedPrescriptionId = $(this).first().data('id');

    //     $.each(cachePrescriptions, function(idx, prescription) {
    //       if (prescription['id'] === selectedPrescriptionId+"") {
    //         var items = [];
    //         $.each(prescription['signatures'], function(idx, signature) {
    //           items.push('<tr class="edit-prescription-row"><td class="edit-prescription-cell"><label>Treatment name</label><input type="text" value="' + signature['rx_name'] + '"><label>Dose</label><div class="control-group"><div class="controls"><input type="text" class="span1" value="' + signature['dose'] + '"><input type="text" class="span2" value="' + signature['dose_unit_label'] + '"></div></div><label>Frequency</label><div class="control-group"><div class="controls"><input type="text" class="span1" value="' + signature['frequency'] + '"><input type="text" class="span2" value="' + signature['frequency_unit'] + '"></div></div><label>Duration</label><div class="control-group"><div class="controls"><input type="text" class="span1" value="' + signature['duration'] + '"><input type="text" class="span2" value="' + signature['duration_unit'] + '"></td></tr>');
    //         });
    //         items = items.join('') + '<tr id="edit-submit-tray"><td><button class="btn" type="button" id="combine-with-button">+ combine with</button><button type="submit" class="btn btn-primary">Save changes</button></td></tr>';
    //         $('#edit-prescription').html(items);

    //         setupEditPrescriptionActions();
    //         setupEditTreatmentSearch();

    //         return;
    //       }
    //     });
    //   });
    // };

    $('#add-prescription-button').click(function () {
        $('.prescription-row').removeClass('info');
        $('#edit-prescription').html(newSignatureRow +
                                '<tr id="edit-submit-tray">' +
                                '<td>Note: <textarea style="height:100%;" id="prescription-note"></textarea></td>' +
                                '<td><button class="btn" style="margin-top: 20px;" ' +
                                    'type="button" id="combine-with-button">+ combine with</button>' +
                                    '<button class="btn btn-primary" type="button" id="save-changes">Save changes</button></td>' +
                                '</tr>');
        setupEditPrescriptionActions();
        setupEditTreatmentSearch();
        $('.edit-treatment-search').data('cui', $('.treatment-row.info').children().data('cui'));
        $('.edit-treatment-search').val($('.treatment-row.info').children().text());
    });

    var setupPrescription = function () {
        //$('.treatment').unbind('click');
        $('.treatment').live("click", function () {
            if (lastRequest) {
                lastRequest.abort();
            }

            $(".loading").remove();
            $('.treatment-row').removeClass('info');
            $(this).parent().addClass('info');
            $('#edit-prescription').empty();
            $('#prescriptions').empty();
            //$('#add-prescription-button').addClass('hidden');

            treatmentCui = $(this).data('cui');

            var handlePrescriptions = function (prescriptions) {
                $('#add-prescription-button').removeClass('hidden');
                var items = [];
                $.each(prescriptions, function (idx, prescription) {
                    $.each(prescription['sigs'], function (idx, signature) {
                        if (signature['rx_code'] === treatmentCui) {
                            var item = "";
                            $.each(prescription['sigs'], function (idx, signature) {


                                var freq = signature['frequency']
                                if (freq == null)
                                    freq = "";

                                var duration = signature['duration']
                                if (duration == null)
                                    duration = "";

                                var brand = signature['brand']
                                if (brand == null)
                                    brand = "";

                                if (signature['dose_high'] == null)
                                    item += "<p><strong>" + signature['name'] + "</strong></br>" + brand + "</p><p>" + signature['dose'] + " " + signature['dose_unit'] + " / " + freq + " " + signature['frequency_unit'] + " / " + duration + " " + signature['duration_unit']
                                else
                                    item += "<p><strong>" + signature['name'] + "</strong></br>" + brand + "</p><p>" + signature['dose'] + "-" + signature['dose_high'] + " " + signature['dose_unit'] + " / " + freq + " " + signature['frequency_unit'] + " / " + duration + " " + signature['duration_unit'] + " " + "</p>";

                                if (prescription['note'] != null)
                                    item += "<br/>" + prescription['note']

                                if (signature['route'] != null)
                                    item += "<br/>" + signature['route']

                                item += " " + "</p>";

                            });
                            item = '<tr class="prescription-row"><td class="prescription" data-id="' + prescription['id'] + '">' + item + '</td></td>';
                            items.push(item);
                            return;
                        }
                    });
                });
                $('#prescriptions').html(items.join(''));
            };

            if (cachePrescriptions) {
                handlePrescriptions(cachePrescriptions);
            } else {
                $(this).append($("#loading-img").clone().removeClass("hidden").attr("id", null).addClass("loading"));
                var params = jQuery.extend({}, authParams);

                lastRequest = $.getJSON('/prescriptions/' + disorderCui + '/', params, function (data) {
                    lastRequest = null;
                    $(".loading").remove();
                    var prescriptions = data['results'];
                    cachePrescriptions = prescriptions;

                    handlePrescriptions(prescriptions);
                });
            }
        });
    };

    var setupTreatmentSearch = function () {
        $('.treatment-search-result').click(function () {
            if (lastRequest) {
                lastRequest.abort();
            }

            $(".loading").remove();
            $('#treatment-search-dropdown-container').removeClass('open');
            clicked = $('#' + $(this).data('cui'));

            if (clicked.size() > 0) {
                clicked.click();
            } else {
                $('#treatment-row').removeClass('info')
                $('#treatments').prepend('<tr class="treatment-row info"><td data-cui="' + $(this).data('cui') + '" class="treatment"  id="' + $(this).data('cui') + '">' + $(this).html() + '</td></tr>');

                $('#add-prescription-button').removeClass('hidden');
                $('.treatment-row.info').find('.treatment').click();
                $('#add-prescription-button').click();
            }
            setupPrescription();
        });
    };

    $('#treatment-search').focus(function () {
        if ($('#treatment-search-results').children().length !== 0) {
            $('#treatment-search-dropdown-container').addClass('open');
        }
    }).blur(function () {
            if ($('#treatment-search-results').children().length === 0) {
                $('#treatment-search-dropdown-container').removeClass('open');
            }
        });

    $('#treatment-search').on('input', function () {
        if (lastRequest) {
            lastRequest.abort();
        }

        $('#treatment-search-results').empty();
        $('#treatment-search-dropdown-container').addClass('open');

        if ($(this).val() === "") {
            $('#treatment-search-results').empty();
            $('#treatment-search-dropdown-container').removeClass('open');
        } else {
            var params = jQuery.extend({}, authParams);
            params['q'] = $(this).val();
            lastRequest = $.getJSON('/treatments/search', params, function (data) {
                lastRequest = null;

                var treatments = data['results'];
                var items = [];
                $.each(treatments, function (idx, treatment) {
                    items.push('<tr><td data-cui="' + treatment['code'] + '" class="treatment-search-result">' + treatment['label'] + '</td></tr>');
                });

                $('#treatment-search-results').html(items.join(''));

                cachePrescriptions = null;
                setupTreatmentSearch();
            });
        }
    });

    var setupTreatment = function () {
        $('.disorder-search-result').live('click', (function () {
            if (lastRequest) {
                lastRequest.abort();
            }

            $(".loading").remove();
            $('.disorder-search-result-row').removeClass('info');
            $(this).parent().addClass('info');
            $('#edit-prescription').empty();
            $('#treatments').empty();
            $('#treatment-search').addClass('hidden');
            $('#prescriptions').empty();
            $('#add-prescription-button').removeClass('hidden');

            $(this).append($("#loading-img").clone().removeClass("hidden").attr("id", null).addClass("loading"));

            if (disorderCui != $(this).data('cui'))
                cachePrescriptions = null;

            disorderCui = $(this).data('cui');

            var params = jQuery.extend({}, authParams);
            lastRequest = $.getJSON('/dashboard/disorders/' + disorderCui + '/', params, function (data) {
                lastRequest = null;

                $(".loading").remove();

                var results = data['results'][0];
                var definition = results['definition'];
                var treatments = results['treatments'];
                
                var items = [];
                def = $('#definition')
//                if (def.size() > 0)
  //                  def.html('Definition: ' + results['definition']);
    //            else
      //              $('#treatments').parent().prepend('<div class="span3" style="height:20px;width:40px;" id="definition">Definition: ' + results['definition'] + '</div>');

                $.each(treatments, function (idx, treatment) {
                    items.push('<tr class="treatment-row"><td data-cui="' + treatment['rx_code'] + '" class="treatment" id="' + treatment['rx_code'] + '">' + treatment['name'] + '</td></tr>');
                });

                $('#treatments').html(items.join(''));

                //$('#treatment-search').removeClass('hidden');
                setupPrescription();
            });
        }));

        $('.prescription').live('click', function () {

                var handlePrescriptions = function (prescriptions, id) {
                    var items = [];
                    $.each(prescriptions, function (idx, prescription) {

                        if (prescription['id'] == id) {
                            $.each(prescription['sigs'], function (idx, signature) {
                                if (signature['rx_code'] === treatmentCui) {
                                    var item = "";
                                    //$.each(prescription['sigs'], function (idx, signature) {
                                        var signa = '<tr class="edit-prescription-row"><td class="edit-prescription-cell"><label class="close remove-signature">&times;</label>' +
                                            '<label>Treatment name</label><div class="dropdown">' +
                                            '<input type="text" class="edit-treatment-search" value="{0}"><table class="table table-hover dropdown-menu edit-treatment-search-results">' +
                                            '</div>'+
                                            '<div class="brand-name">'+
                                            '<label>Brand name</label>'+
                                            '<input type="text" placeholder="Enter for free input only" value="{11}" class="brand-input">'+
                                            '</div>'+
                                            '</table></div><label>Dose</label><div class="control-group"><div class="controls"><div class="dropdown">' +
                                            '<input type="text" class="span1 dose-input" value="{1}">' +
                                            '<input type="text" class="span1 dose-high-input" value="{2}">' +
                                            '<input type="text" class="span2 dose-label-input" value="{3}"><div class="control-group"><div class="controls"><div class="dropdown">' +
                                            '<input type="text" class="span1 frequency-input"  value="{4}">' +
                                            '<input type="text" class="span1 frequency-high-input"  value="{5}">' +
                                            '<input type="text" class="span2 frequency-label-input" value="{6}"><table class="table table-hover dropdown-menu">' +
                                            '</table></div></div></div><label>Duration</label><div class="control-group"><div class="controls"><div class="dropdown">' +
                                            '<input type="text" class="span1 duration-input" value="{7}">' +
                                            '<input type="text" class="span1 duration-high-input" value="{8}">' +
                                            '<input type="text" class="span2 duration-label-input" value="days" value="{9}">' +
                                            '<label>Route</label>' +
                                            '<input type="text" class="span2 route-label-input" value="{10}">' +
                                            '<table class="table table-hover dropdown-menu"></table></div></div></div></td></tr>';

                                        var rx_name = signature['name'];
                                        if (rx_name == null)
                                            rx_name = "";
                                        var brand = signature['brand'];
                                        if (brand == null)
                                            brand = "";
                                        var dose = signature['dose']
                                        if (dose == null)
                                            dose = "";
                                        var dose_high = signature['dose_high']
                                        if (dose_high == null)
                                            dose_high = "";
                                        var dose_unit = signature['dose_unit']
                                        if (dose_unit == null)
                                            dose_unit = "";
                                        var freq = signature['frequency']
                                        if (freq == null)
                                            freq = "";
                                        var freq_high = signature['frequency_high']
                                        if (freq_high == null)
                                            freq_high = "";
                                        var fu = signature['frequency_unit']
                                        if (fu == null)
                                            fu = "";
                                        var d = signature['duration']
                                        if (d == null)
                                            d = "";
                                        var dur_high = signature['duration_high']
                                        if (dur_high == null)
                                            dur_high = "";
                                        var du = signature['duration_unit']
                                        if (du == null)
                                            du = "";
                                        var r = signature['route']
                                        if (r == null)
                                            r = "";

                                        item = signa.format(rx_name, dose, dose_high, dose_unit, freq, freq_high, fu, d, dur_high, du, r, brand)
                                    ;
                                    item = '<tr class="edit-prescription-row"><td class="prescription" data-id="' + prescription['id'] + '">' + item + '</td></td>';
                                    items.push(item);
                                }
                            });

                            //$('#edit-prescription').join('<tr id="edit-submit-tray"><td>Note: <textarea style="height:100%;" id="prescription-note" value="' + prescription['note'] + '></textarea></td><td><button class="btn" style="margin-top: 20px;" type="button" id="combine-with-button">+ combine with</button><button class="btn btn-primary" type="button" id="save-changes">Save changes</button></td></tr>');
                        }
                    });
                    $('#edit-prescription').html(items.join(''));
                };

                $('.prescription-row').removeClass('info');
                $(this).parent().addClass('info');

                 if (cachePrescriptions) {
                     handlePrescriptions(cachePrescriptions, $(this).data('cui'));
                 }
                //  else {
                //     $(this).append($("#loading-img").clone().removeClass("hidden").attr("id", null).addClass("loading"));
                //     var params = jQuery.extend({}, authParams);
                //     //params['cui'] = disorderCui;
                //     lastRequest = $.getJSON('/api/v1/prescription/get/', params, function (data) {
                //         lastRequest = null;
                //         $(".loading").remove();
                //         var prescriptions = data['prescription'];
                //         cachePrescriptions = prescriptions;

                //         handlePrescriptions(prescriptions, $(this).data('cui'))
                //     });
                // }

              setupEditPrescriptionActions();
              setupEditTreatmentSearch();
              $('.edit-treatment-search').data('cui', $('.treatment-row.info').children().data('cui'));
              $('.edit-treatment-search').val($('.treatment-row.info').children().text());
            }
        );
    };


    $('#disorder-search').on('input', function () {
        if (lastRequest) {
            lastRequest.abort();
        }

        $('#edit-prescription').empty();
        $('#disorder-search-results').empty();
        $('#treatments').empty();
        $('#treatment-search').addClass('hidden');
        $('#prescriptions').empty();
        $('#add-prescription-button').addClass('hidden');

        var params = jQuery.extend({}, authParams);
        params['q'] = $(this).val();
        lastRequest = $.getJSON('/dashboard/disorders/search', params, function (data) {
            lastRequest = null;

            var disorders = data['results'];
            var items = [];
            $.each(disorders, function (idx, disorder) {
                items.push('<tr class="disorder-search-result-row"><td data-cui="' + disorder['code'] + '" class="disorder-search-result">' + disorder['label'] + '</td></tr>');
            });

            $('#disorder-search-results').html(items.join(''));

            setupTreatment();
        });


    });
    setupTreatment();


});