/// <reference path='../../../typings/hibachiTypescript.d.ts' />
/// <reference path='../../../typings/tsd.d.ts' />


import {SWValidationEmail} from "./swvalidationemail";

class test{
    constructor(

    ){
        describe('swValidationEmail Test',()=>{
            var $compile,$rootScope, form, element;
            beforeEach(()=>{
                angular.module('ngAnimate',[]);
                angular.module('ngSanitize',[]);
                angular.module('ui.bootstrap',[]);
                angular.module('hibachi.core',['ngAnimate','ngSanitize','ui.bootstrap']);
                angular.mock.module('hibachi.validation');
                angular.mock.module(($provide)=>{
                    $provide.service('validationService', ()=>{
                        const MY_EMAIL_REGEXP =  /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                        return {
                            validateEmail: (value)=>{
                                return MY_EMAIL_REGEXP.test(value);
                            }
                        }
                    })
                })

            });

            beforeEach(inject((_$compile_,_$rootScope_)=>{
                $compile = _$compile_;
                $rootScope = _$rootScope_;

                var elString = '<form name="form"><input type="email" sw-validation-email ng-model="model.email" name="emailInput"></form>';
                $rootScope.model = {email:null};
                element = element = $compile(elString)($rootScope);
                form = $rootScope.form;
            }));

            it('Should be valid if given a valid email',()=>{
                form.emailInput.$setViewValue('ryan.marchand@ten24web.com');
                $rootScope.$digest();
                console.info('test');
                angular.mock.dump(element.attr('sw-validation-email-valid'));
               // expect(element.attr('sw-validation-email-valid')).toContain('sw-validation-email-valid');
            });

            it('Should be invalid if given an invalid email', ()=>{
                form.emailInput.$setViewValue('ryan.marchandten24web.com');
                $rootScope.$digest();
                expect(form.emailInput.$error.swValidationEmail).toBeTruthy();

                form.emailInput.$setViewValue('ryan.marchandten24web.com@');
                $rootScope.$digest();
                expect(form.emailInput.$error.swValidationEmail).toBeTruthy();

                form.emailInput.$setViewValue('@yan.marchandten24web.com');
                $rootScope.$digest();
                expect(form.emailInput.$error.swValidationEmail).toBeTruthy();
            })
        });
    }
}
new test();