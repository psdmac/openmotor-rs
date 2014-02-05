(function(e,r){"use strict";function t(){function e(e,t){return r.extend(new(r.extend(function(){},{prototype:e})),t)}function t(e,r){var t=r.caseInsensitiveMatch,n={originalPath:e,regexp:e},a=n.keys=[];return e=e.replace(/([().])/g,"\\$1").replace(/(\/)?:(\w+)([\?|\*])?/g,function(e,r,t,n){var o="?"===n?n:null,c="*"===n?n:null;return a.push({name:t,optional:!!o}),r=r||"",""+(o?"":r)+"(?:"+(o?r:"")+(c&&"(.+?)"||"([^/]+)")+(o||"")+")"+(o||"")}).replace(/([\/$\*])/g,"\\$1"),n.regexp=new RegExp("^"+e+"$",t?"i":""),n}var n={};this.when=function(e,a){if(n[e]=r.extend({reloadOnSearch:!0},a,e&&t(e,a)),e){var o="/"==e[e.length-1]?e.substr(0,e.length-1):e+"/";n[o]=r.extend({redirectTo:e},t(o,a))}return this},this.otherwise=function(e){return this.when(null,e),this},this.$get=["$rootScope","$location","$routeParams","$q","$injector","$http","$templateCache","$sce",function(t,a,o,c,i,l,u,s){function p(e,r){var t=r.keys,n={};if(!r.regexp)return null;var a=r.regexp.exec(e);if(!a)return null;for(var o=1,c=a.length;c>o;++o){var i=t[o-1],l="string"==typeof a[o]?decodeURIComponent(a[o]):a[o];i&&l&&(n[i.name]=l)}return n}function $(){var e=h(),n=m.current;e&&n&&e.$$route===n.$$route&&r.equals(e.pathParams,n.pathParams)&&!e.reloadOnSearch&&!f?(n.params=e.params,r.copy(n.params,o),t.$broadcast("$routeUpdate",n)):(e||n)&&(f=!1,t.$broadcast("$routeChangeStart",e,n),m.current=e,e&&e.redirectTo&&(r.isString(e.redirectTo)?a.path(d(e.redirectTo,e.params)).search(e.params).replace():a.url(e.redirectTo(e.pathParams,a.path(),a.search())).replace()),c.when(e).then(function(){if(e){var t,n,a=r.extend({},e.resolve);return r.forEach(a,function(e,t){a[t]=r.isString(e)?i.get(e):i.invoke(e)}),r.isDefined(t=e.template)?r.isFunction(t)&&(t=t(e.params)):r.isDefined(n=e.templateUrl)&&(r.isFunction(n)&&(n=n(e.params)),n=s.getTrustedResourceUrl(n),r.isDefined(n)&&(e.loadedTemplateUrl=n,t=l.get(n,{cache:u}).then(function(e){return e.data}))),r.isDefined(t)&&(a.$template=t),c.all(a)}}).then(function(a){e==m.current&&(e&&(e.locals=a,r.copy(e.params,o)),t.$broadcast("$routeChangeSuccess",e,n))},function(r){e==m.current&&t.$broadcast("$routeChangeError",e,n,r)}))}function h(){var t,o;return r.forEach(n,function(n){!o&&(t=p(a.path(),n))&&(o=e(n,{params:r.extend({},a.search(),t),pathParams:t}),o.$$route=n)}),o||n[null]&&e(n[null],{params:{},pathParams:{}})}function d(e,t){var n=[];return r.forEach((e||"").split(":"),function(e,r){if(0===r)n.push(e);else{var a=e.match(/(\w+)(.*)/),o=a[1];n.push(t[o]),n.push(a[2]||""),delete t[o]}}),n.join("")}var f=!1,m={routes:n,reload:function(){f=!0,t.$evalAsync($)}};return t.$on("$locationChangeSuccess",$),m}]}function n(){this.$get=function(){return{}}}function a(e,t,n,a,o){return{restrict:"ECA",terminal:!0,priority:400,transclude:"element",link:function(c,i,l,u,s){function p(){h&&(h.$destroy(),h=null),d&&(o.leave(d),d=null)}function $(){var l=e.current&&e.current.locals,u=l&&l.$template;if(u){var $=c.$new(),g=s($,r.noop);g.html(u),o.enter(g,null,d||i,function(){!r.isDefined(f)||f&&!c.$eval(f)||t()}),p();var v=n(g.contents()),w=e.current;if(h=w.scope=$,d=g,w.controller){l.$scope=h;var C=a(w.controller,l);w.controllerAs&&(h[w.controllerAs]=C),g.data("$ngControllerController",C),g.children().data("$ngControllerController",C)}v(h),h.$emit("$viewContentLoaded"),h.$eval(m)}else p()}var h,d,f=l.autoscroll,m=l.onload||"";c.$on("$routeChangeSuccess",$),$()}}}var o=r.module("ngRoute",["ng"]).provider("$route",t);o.provider("$routeParams",n),o.directive("ngView",a),a.$inject=["$route","$anchorScroll","$compile","$controller","$animate"]})(window,window.angular);