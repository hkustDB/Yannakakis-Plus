create or replace view tAux33 as select id as v53, title as v54 from title where production_year>2000;
create or replace view nAux2 as select id as v42, name as v43 from name where gender= 'f';
create or replace view semiUp6957976173799756035 as select person_id as v42, movie_id as v53, person_role_id as v9, role_id as v51 from cast_info AS ci where (person_role_id) in (select id from char_name AS chn) and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)');
create or replace view semiUp2181747851032968263 as select movie_id as v53, info_type_id as v30 from movie_info AS mi where (info_type_id) in (select id from info_type AS it where info= 'release dates');
create or replace view semiUp2495045376559604985 as select v42, v53, v9, v51 from semiUp6957976173799756035 where (v51) in (select id from role_type AS rt where role= 'actress');
create or replace view semiUp1837482304620835600 as select movie_id as v53, company_id as v23 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp3566237264044564714 as select v53, v30 from semiUp2181747851032968263 where (v53) in (select v53 from semiUp1837482304620835600);
create or replace view semiUp4045740804648722337 as select v42, v53, v9, v51 from semiUp2495045376559604985 where (v42) in (select person_id from aka_name AS an);
create or replace view semiUp4145893353215622056 as select v42, v53, v9, v51 from semiUp4045740804648722337 where (v53) in (select v53 from semiUp3566237264044564714);
create or replace view semiUp5563542090921571301 as select v42, v53, v9, v51 from semiUp4145893353215622056 where (v53) in (select v53 from tAux33);
create or replace view semiUp8754159665407607138 as select v42, v43 from nAux2 where (v42) in (select v42 from semiUp5563542090921571301);
create or replace view semiDown8276857873266788032 as select v42, v53, v9, v51 from semiUp5563542090921571301 where (v42) in (select v42 from semiUp8754159665407607138);
create or replace view semiDown2352793104904199913 as select id as v42, name as v43 from name AS n where (id, name) in (select v42, v43 from semiUp8754159665407607138) and gender= 'f';
create or replace view semiDown4076428313028153999 as select id as v51 from role_type AS rt where (id) in (select v51 from semiDown8276857873266788032) and role= 'actress';
create or replace view semiDown7278940039780248196 as select person_id as v42 from aka_name AS an where (person_id) in (select v42 from semiDown8276857873266788032);
create or replace view semiDown7905719469037571734 as select v53, v54 from tAux33 where (v53) in (select v53 from semiDown8276857873266788032);
create or replace view semiDown6253120671735931951 as select id as v9 from char_name AS chn where (id) in (select v9 from semiDown8276857873266788032);
create or replace view semiDown6129332559816865430 as select v53, v30 from semiUp3566237264044564714 where (v53) in (select v53 from semiDown8276857873266788032);
create or replace view semiDown4492808303799190532 as select id as v53, title as v54 from title AS t where (id, title) in (select v53, v54 from semiDown7905719469037571734) and production_year>2000;
create or replace view semiDown3053002827407756538 as select id as v30 from info_type AS it where (id) in (select v30 from semiDown6129332559816865430) and info= 'release dates';
create or replace view semiDown212215105996719355 as select v53, v23 from semiUp1837482304620835600 where (v53) in (select v53 from semiDown6129332559816865430);
create or replace view semiDown3852216817889206535 as select id as v23 from company_name AS cn where (id) in (select v23 from semiDown212215105996719355) and country_code= '[us]';
create or replace view aggView864790823948007240 as select v53, v54, v54 as v66 from semiDown4492808303799190532;
create or replace view aggView6342344641024681258 as select v42, v43, v43 as v65 from semiDown2352793104904199913;
create or replace view aggView6131008772878724276 as select v23 from semiDown3852216817889206535;
create or replace view aggJoin4307554673479273204 as select v53 from semiDown212215105996719355 join aggView6131008772878724276 using(v23);
create or replace view aggView6267147511741215955 as select v30 from semiDown3053002827407756538;
create or replace view aggJoin3779508601502277582 as select v53 from semiDown6129332559816865430 join aggView6267147511741215955 using(v30);
create or replace view aggView8575403766678887065 as select v53 from aggJoin4307554673479273204 group by v53;
create or replace view aggJoin2492131555216436507 as select v53 from aggJoin3779508601502277582 join aggView8575403766678887065 using(v53);
create or replace view aggView7533323442696201188 as select v51 from semiDown4076428313028153999;
create or replace view aggJoin3786725645368202537 as select v42, v53, v9 from semiDown8276857873266788032 join aggView7533323442696201188 using(v51);
create or replace view aggView5324135696483363346 as select v42 from semiDown7278940039780248196 group by v42;
create or replace view aggJoin3257356331020167723 as select v42, v53, v9 from aggJoin3786725645368202537 join aggView5324135696483363346 using(v42);
create or replace view aggView2851530645326800989 as select v53 from aggJoin2492131555216436507 group by v53;
create or replace view aggJoin2086215104646050337 as select v42, v53, v9 from aggJoin3257356331020167723 join aggView2851530645326800989 using(v53);
create or replace view aggView8828751435670618067 as select v9 from semiDown6253120671735931951;
create or replace view aggJoin36668953946069862 as select v42, v53 from aggJoin2086215104646050337 join aggView8828751435670618067 using(v9);
create or replace view aggView3115163452096577950 as select v53, MIN(v66) as v66 from aggView864790823948007240 group by v53,v66;
create or replace view aggJoin2668233150445258226 as select v42, v66 from aggJoin36668953946069862 join aggView3115163452096577950 using(v53);
create or replace view aggView8836023636155784440 as select v42, MIN(v66) as v66 from aggJoin2668233150445258226 group by v42,v66;
create or replace view aggJoin4346989006809766920 as select v65 as v65, v66 from aggView6342344641024681258 join aggView8836023636155784440 using(v42);
select MIN(v65) as v65, MIN(v66) as v66 from aggJoin4346989006809766920;

