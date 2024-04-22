create or replace view aggJoin7488151838754946560 as (
with aggView937406500409419864 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView937406500409419864 where ci.person_id=aggView937406500409419864.v31);
create or replace view aggJoin4016099405783961289 as (
with aggView295935549071555445 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin7488151838754946560 join aggView295935549071555445 using(v9));
create or replace view aggJoin642813016891427824 as (
with aggView6387459422783685283 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6387459422783685283 where t.kind_id=aggView6387459422783685283.v26 and production_year>2000);
create or replace view aggJoin663056800740984602 as (
with aggView7267882139271328169 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7267882139271328169 where cc.status_id=aggView7267882139271328169.v7);
create or replace view aggJoin4588722114185451623 as (
with aggView8702101510328612566 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView8702101510328612566 where mk.keyword_id=aggView8702101510328612566.v23);
create or replace view aggJoin2831041934448389313 as (
with aggView8343758785926156055 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin663056800740984602 join aggView8343758785926156055 using(v5));
create or replace view aggJoin7786018960509281801 as (
with aggView6380887307231452302 as (select v40 from aggJoin2831041934448389313 group by v40)
select v40 from aggJoin4588722114185451623 join aggView6380887307231452302 using(v40));
create or replace view aggJoin1069050536554333154 as (
with aggView7726737661993582170 as (select v40 from aggJoin7786018960509281801 group by v40)
select v40, v41, v44 from aggJoin642813016891427824 join aggView7726737661993582170 using(v40));
create or replace view aggJoin3306305009892132793 as (
with aggView7887741179101446126 as (select v40, MIN(v41) as v53 from aggJoin1069050536554333154 group by v40)
select v52 as v52, v53 from aggJoin4016099405783961289 join aggView7887741179101446126 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin3306305009892132793;
