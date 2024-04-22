create or replace view aggJoin1113252445226882962 as (
with aggView8773875022281715832 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView8773875022281715832 where ci.person_id=aggView8773875022281715832.v31);
create or replace view aggJoin7104851277081740074 as (
with aggView52875373213321538 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin1113252445226882962 join aggView52875373213321538 using(v9));
create or replace view aggJoin6000379097963450547 as (
with aggView8750351945472191021 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8750351945472191021 where t.kind_id=aggView8750351945472191021.v26 and production_year>2000);
create or replace view aggJoin8025573744702758356 as (
with aggView6326005615592554841 as (select v40, MIN(v41) as v53 from aggJoin6000379097963450547 group by v40)
select movie_id as v40, keyword_id as v23, v53 from movie_keyword as mk, aggView6326005615592554841 where mk.movie_id=aggView6326005615592554841.v40);
create or replace view aggJoin8448368763158503868 as (
with aggView5876768064866530040 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView5876768064866530040 where cc.status_id=aggView5876768064866530040.v7);
create or replace view aggJoin2842158150807740811 as (
with aggView437465663441113849 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v40, v53 from aggJoin8025573744702758356 join aggView437465663441113849 using(v23));
create or replace view aggJoin5261119985732584034 as (
with aggView4061998527236222229 as (select v40, MIN(v53) as v53 from aggJoin2842158150807740811 group by v40,v53)
select v40, v5, v53 from aggJoin8448368763158503868 join aggView4061998527236222229 using(v40));
create or replace view aggJoin6658535777777659839 as (
with aggView5587202277454672016 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40, v53 from aggJoin5261119985732584034 join aggView5587202277454672016 using(v5));
create or replace view aggJoin8051029586899987115 as (
with aggView7011921714449962777 as (select v40, MIN(v53) as v53 from aggJoin6658535777777659839 group by v40,v53)
select v52 as v52, v53 from aggJoin7104851277081740074 join aggView7011921714449962777 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin8051029586899987115;
