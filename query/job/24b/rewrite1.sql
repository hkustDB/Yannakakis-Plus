create or replace view aggJoin1399289728658007143 as (
with aggView8627384422616676734 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView8627384422616676734 where ci.person_role_id=aggView8627384422616676734.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3780775792543257519 as (
with aggView8483207490235352644 as (select id as v59, title as v73 from title as t where title LIKE 'Kung Fu Panda%' and production_year>2010)
select movie_id as v59, info_type_id as v30, info as v43, v73 from movie_info as mi, aggView8483207490235352644 where mi.movie_id=aggView8483207490235352644.v59 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5390280588957044509 as (
with aggView608245913333235517 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, v72 from aka_name as an, aggView608245913333235517 where an.person_id=aggView608245913333235517.v48);
create or replace view aggJoin6080319961681871224 as (
with aggView1973629294923289650 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71 from aggJoin1399289728658007143 join aggView1973629294923289650 using(v57));
create or replace view aggJoin267463677272720036 as (
with aggView5420324163165011824 as (select id as v30 from info_type as it where info= 'release dates')
select v59, v43, v73 from aggJoin3780775792543257519 join aggView5420324163165011824 using(v30));
create or replace view aggJoin2593040903113880470 as (
with aggView1136151127167306770 as (select v48, MIN(v72) as v72 from aggJoin5390280588957044509 group by v48,v72)
select v59, v20, v71 as v71, v72 from aggJoin6080319961681871224 join aggView1136151127167306770 using(v48));
create or replace view aggJoin1251345800092998831 as (
with aggView22663507591153645 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView22663507591153645 where mk.keyword_id=aggView22663507591153645.v32);
create or replace view aggJoin8642640471824392518 as (
with aggView8178053608510403620 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin2593040903113880470 group by v59,v72,v71)
select v59, v71, v72 from aggJoin1251345800092998831 join aggView8178053608510403620 using(v59));
create or replace view aggJoin1805890497349114040 as (
with aggView8000265529697809302 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView8000265529697809302 where mc.company_id=aggView8000265529697809302.v23);
create or replace view aggJoin4596408631638933708 as (
with aggView5343888802238700135 as (select v59 from aggJoin1805890497349114040 group by v59)
select v59, v43, v73 as v73 from aggJoin267463677272720036 join aggView5343888802238700135 using(v59));
create or replace view aggJoin8496536113276577519 as (
with aggView3194611769058074887 as (select v59, MIN(v73) as v73 from aggJoin4596408631638933708 group by v59,v73)
select v71 as v71, v72 as v72, v73 from aggJoin8642640471824392518 join aggView3194611769058074887 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin8496536113276577519;
