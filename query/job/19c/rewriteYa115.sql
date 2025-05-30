create or replace view semiUp5021635883966717970 as select person_id as v42, movie_id as v53, person_role_id as v9, role_id as v51 from cast_info AS ci where (person_id) in (select id from name AS n where name LIKE '%An%' and gender= 'f') and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)');
create or replace view semiUp7660321691936483757 as select movie_id as v53, info_type_id as v30 from movie_info AS mi where (info_type_id) in (select id from info_type AS it where info= 'release dates') and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%'));
create or replace view semiUp9138537933881539775 as select v42, v53, v9, v51 from semiUp5021635883966717970 where (v42) in (select person_id from aka_name AS an);
create or replace view semiUp10420684640872 as select movie_id as v53, company_id as v23 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp5310817194396410906 as select v42, v53, v9, v51 from semiUp9138537933881539775 where (v9) in (select id from char_name AS chn);
create or replace view semiUp7863332990313543958 as select v42, v53, v9, v51 from semiUp5310817194396410906 where (v51) in (select id from role_type AS rt where role= 'actress');
create or replace view semiUp7013907792957834833 as select id as v53, title as v54 from title AS t where (id) in (select v53 from semiUp7660321691936483757) and production_year>2000;
create or replace view semiUp8385149815150300054 as select v42, v53, v9, v51 from semiUp7863332990313543958 where (v53) in (select v53 from semiUp7013907792957834833);
create or replace view semiUp4959759032926336448 as select v53, v23 from semiUp10420684640872 where (v53) in (select v53 from semiUp8385149815150300054);
create or replace view semiDown5938746569000065076 as select id as v23 from company_name AS cn where (id) in (select v23 from semiUp4959759032926336448) and country_code= '[us]';
create or replace view semiDown4853963462395793037 as select v42, v53, v9, v51 from semiUp8385149815150300054 where (v53) in (select v53 from semiUp4959759032926336448);
create or replace view semiDown3127372546192825988 as select id as v51 from role_type AS rt where (id) in (select v51 from semiDown4853963462395793037) and role= 'actress';
create or replace view semiDown6957571092351186493 as select id as v42, name as v43 from name AS n where (id) in (select v42 from semiDown4853963462395793037) and name LIKE '%An%' and gender= 'f';
create or replace view semiDown5068452165447424960 as select person_id as v42 from aka_name AS an where (person_id) in (select v42 from semiDown4853963462395793037);
create or replace view semiDown498268261561248174 as select v53, v54 from semiUp7013907792957834833 where (v53) in (select v53 from semiDown4853963462395793037);
create or replace view semiDown1205162114435309257 as select id as v9 from char_name AS chn where (id) in (select v9 from semiDown4853963462395793037);
create or replace view semiDown5781083476881567355 as select v53, v30 from semiUp7660321691936483757 where (v53) in (select v53 from semiDown498268261561248174);
create or replace view semiDown2329380849198690219 as select id as v30 from info_type AS it where (id) in (select v30 from semiDown5781083476881567355) and info= 'release dates';
create or replace view aggView5367684470076634288 as select v30 from semiDown2329380849198690219;
create or replace view aggJoin2390864551999048129 as select v53 from semiDown5781083476881567355 join aggView5367684470076634288 using(v30);
create or replace view aggView5401194704224406665 as select v53 from aggJoin2390864551999048129 group by v53;
create or replace view aggJoin1703551433323081166 as select v53, v54 from semiDown498268261561248174 join aggView5401194704224406665 using(v53);
create or replace view aggView9067132434358872190 as select v42, v43 as v65 from semiDown6957571092351186493;
create or replace view aggJoin5829019168236983764 as select v42, v53, v9, v51, v65 from semiDown4853963462395793037 join aggView9067132434358872190 using(v42);
create or replace view aggView4439933072234660884 as select v51 from semiDown3127372546192825988;
create or replace view aggJoin57419271284937193 as select v42, v53, v9, v65 from aggJoin5829019168236983764 join aggView4439933072234660884 using(v51);
create or replace view aggView6451417012943997682 as select v42 from semiDown5068452165447424960 group by v42;
create or replace view aggJoin6752744269547154794 as select v53, v9, v65 as v65 from aggJoin57419271284937193 join aggView6451417012943997682 using(v42);
create or replace view aggView4744134068039472767 as select v9 from semiDown1205162114435309257;
create or replace view aggJoin8739949923931199068 as select v53, v65 from aggJoin6752744269547154794 join aggView4744134068039472767 using(v9);
create or replace view aggView2067930503985960957 as select v53, MIN(v54) as v66 from aggJoin1703551433323081166 group by v53;
create or replace view aggJoin6342140456000134597 as select v53, v65 as v65, v66 from aggJoin8739949923931199068 join aggView2067930503985960957 using(v53);
create or replace view aggView2982447147547296297 as select v23 from semiDown5938746569000065076;
create or replace view aggJoin3529930405255662573 as select v53 from semiUp4959759032926336448 join aggView2982447147547296297 using(v23);
create or replace view aggView8411358424662801853 as select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin6342140456000134597 group by v53,v66,v65;
create or replace view aggJoin4946433082848754018 as select v65, v66 from aggJoin3529930405255662573 join aggView8411358424662801853 using(v53);
select MIN(v65) as v65, MIN(v66) as v66 from aggJoin4946433082848754018;

