create or replace view semiUp7211761399838555892 as select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast AS cc where (subject_id) in (select id from comp_cast_type AS cct1 where kind= 'cast');
create or replace view semiUp4152758247931115215 as select id as v40, title as v41, kind_id as v26 from title AS t where (kind_id) in (select id from kind_type AS kt where kind= 'movie') and production_year>2000;
create or replace view semiUp108835141564630960 as select movie_id as v40, keyword_id as v23 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'));
create or replace view semiUp7018402554199478787 as select person_id as v31, movie_id as v40, person_role_id as v9 from cast_info AS ci where (person_role_id) in (select id from char_name AS chn where ((name LIKE '%man%') OR (name LIKE '%Man%')));
create or replace view semiUp4154337145299371505 as select v40, v5, v7 from semiUp7211761399838555892 where (v7) in (select id from comp_cast_type AS cct2 where kind LIKE '%complete%');
create or replace view semiUp5317541522950413131 as select v40, v41, v26 from semiUp4152758247931115215 where (v40) in (select v40 from semiUp4154337145299371505);
create or replace view semiUp2787014659901774648 as select v40, v41, v26 from semiUp5317541522950413131 where (v40) in (select v40 from semiUp108835141564630960);
create or replace view semiUp8925562414481138799 as select v31, v40, v9 from semiUp7018402554199478787 where (v40) in (select v40 from semiUp2787014659901774648);
create or replace view semiUp4924315546006968536 as select v31, v40, v9 from semiUp8925562414481138799 where (v31) in (select id from name AS n);
create or replace view semiDown8958328793729653883 as select id as v9 from char_name AS chn where (id) in (select v9 from semiUp4924315546006968536) and ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view semiDown1111264382615762494 as select v40, v41, v26 from semiUp2787014659901774648 where (v40) in (select v40 from semiUp4924315546006968536);
create or replace view semiDown1397411963836896697 as select id as v31, name as v32 from name AS n where (id) in (select v31 from semiUp4924315546006968536);
create or replace view semiDown7953973032670327928 as select id as v26 from kind_type AS kt where (id) in (select v26 from semiDown1111264382615762494) and kind= 'movie';
create or replace view semiDown456647594098159385 as select v40, v5, v7 from semiUp4154337145299371505 where (v40) in (select v40 from semiDown1111264382615762494);
create or replace view semiDown4260154047342253577 as select v40, v23 from semiUp108835141564630960 where (v40) in (select v40 from semiDown1111264382615762494);
create or replace view semiDown6825798455670036372 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown456647594098159385) and kind LIKE '%complete%';
create or replace view semiDown5752751653154817044 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown456647594098159385) and kind= 'cast';
create or replace view semiDown2164871541604577741 as select id as v23 from keyword AS k where (id) in (select v23 from semiDown4260154047342253577) and keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser');
create or replace view aggView2600287174575549662 as select v23 from semiDown2164871541604577741;
create or replace view aggJoin8894665066518106867 as select v40 from semiDown4260154047342253577 join aggView2600287174575549662 using(v23);
create or replace view aggView6822505533020649576 as select v7 from semiDown6825798455670036372;
create or replace view aggJoin1541087406871168982 as select v40, v5 from semiDown456647594098159385 join aggView6822505533020649576 using(v7);
create or replace view aggView7848077988474026863 as select v5 from semiDown5752751653154817044;
create or replace view aggJoin7886827805617673863 as select v40 from aggJoin1541087406871168982 join aggView7848077988474026863 using(v5);
create or replace view aggView6344001372070191999 as select v26 from semiDown7953973032670327928;
create or replace view aggJoin4315861471503640563 as select v40, v41 from semiDown1111264382615762494 join aggView6344001372070191999 using(v26);
create or replace view aggView7980272846175748569 as select v40 from aggJoin8894665066518106867 group by v40;
create or replace view aggJoin6476786924486761611 as select v40, v41 from aggJoin4315861471503640563 join aggView7980272846175748569 using(v40);
create or replace view aggView9174674199502412457 as select v40 from aggJoin7886827805617673863 group by v40;
create or replace view aggJoin2442608355463562440 as select v40, v41 from aggJoin6476786924486761611 join aggView9174674199502412457 using(v40);
create or replace view aggView5736098400151950519 as select v9 from semiDown8958328793729653883;
create or replace view aggJoin8514833941132430646 as select v31, v40 from semiUp4924315546006968536 join aggView5736098400151950519 using(v9);
create or replace view aggView9143880945409498136 as select v40, MIN(v41) as v53 from aggJoin2442608355463562440 group by v40;
create or replace view aggJoin7878176868207802854 as select v31, v53 from aggJoin8514833941132430646 join aggView9143880945409498136 using(v40);
create or replace view aggView5259863587669525214 as select v31, v32 as v52 from semiDown1397411963836896697;
create or replace view aggJoin4533564302452529209 as select v53, v52 from aggJoin7878176868207802854 join aggView5259863587669525214 using(v31);
select MIN(v52) as v52, MIN(v53) as v53 from aggJoin4533564302452529209;

