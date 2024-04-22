create or replace view aggView3996511017451010956 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin341953298236885566 as (
with aggView444257182686784503 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView444257182686784503 where cc.status_id=aggView444257182686784503.v7);
create or replace view aggJoin5117959340869688575 as (
with aggView4502357353354288911 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin341953298236885566 join aggView4502357353354288911 using(v5));
create or replace view aggJoin2881627814871886003 as (
with aggView1950873654533189981 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1950873654533189981 where mi_idx.info_type_id=aggView1950873654533189981.v23);
create or replace view aggJoin8663415369002927391 as (
with aggView4349153007522741001 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4349153007522741001 where t.kind_id=aggView4349153007522741001.v28 and production_year>2000);
create or replace view aggView350862741918078712 as select v48, v47 from aggJoin8663415369002927391 group by v48,v47;
create or replace view aggJoin7738972539903985770 as (
with aggView5069211041561607171 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5069211041561607171 where mk.keyword_id=aggView5069211041561607171.v25);
create or replace view aggJoin3714236084680744492 as (
with aggView1885726655447684551 as (select v47 from aggJoin7738972539903985770 group by v47)
select v47, v33 from aggJoin2881627814871886003 join aggView1885726655447684551 using(v47));
create or replace view aggJoin5097340222626091110 as (
with aggView1679682192137534390 as (select v47 from aggJoin5117959340869688575 group by v47)
select v47, v33 from aggJoin3714236084680744492 join aggView1679682192137534390 using(v47));
create or replace view aggView4552679281512035049 as select v33, v47 from aggJoin5097340222626091110 group by v33,v47;
create or replace view aggJoin906245087888649929 as (
with aggView1667959171265529180 as (select v9, MIN(v10) as v59 from aggView3996511017451010956 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1667959171265529180 where ci.person_role_id=aggView1667959171265529180.v9);
create or replace view aggJoin6113230364411737538 as (
with aggView737978674702312232 as (select v47, MIN(v48) as v61 from aggView350862741918078712 group by v47)
select v33, v47, v61 from aggView4552679281512035049 join aggView737978674702312232 using(v47));
create or replace view aggJoin6306847517322708280 as (
with aggView4384292148156829729 as (select id as v38 from name as n)
select v47, v59 from aggJoin906245087888649929 join aggView4384292148156829729 using(v38));
create or replace view aggJoin2446720123123850498 as (
with aggView336603928331844264 as (select v47, MIN(v59) as v59 from aggJoin6306847517322708280 group by v47,v59)
select v33, v61 as v61, v59 from aggJoin6113230364411737538 join aggView336603928331844264 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin2446720123123850498;
