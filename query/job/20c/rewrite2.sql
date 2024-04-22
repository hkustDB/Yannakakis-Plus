create or replace view aggView4540391901998694714 as select name as v32, id as v31 from name as n;
create or replace view aggJoin3772156364578035041 as (
with aggView8071649555709770739 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8071649555709770739 where t.kind_id=aggView8071649555709770739.v26 and production_year>2000);
create or replace view aggView5725655701918725366 as select v40, v41 from aggJoin3772156364578035041 group by v40,v41;
create or replace view aggJoin8977536708358525152 as (
with aggView8905568526949384311 as (select v31, MIN(v32) as v52 from aggView4540391901998694714 group by v31)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView8905568526949384311 where ci.person_id=aggView8905568526949384311.v31);
create or replace view aggJoin3165484397874406848 as (
with aggView1960476490021119381 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin8977536708358525152 join aggView1960476490021119381 using(v9));
create or replace view aggJoin1430329807491189867 as (
with aggView7731491570346737936 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7731491570346737936 where cc.status_id=aggView7731491570346737936.v7);
create or replace view aggJoin5387989348482984860 as (
with aggView7300270125952237221 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView7300270125952237221 where mk.keyword_id=aggView7300270125952237221.v23);
create or replace view aggJoin7794132380537501809 as (
with aggView2458803366674959710 as (select v40 from aggJoin5387989348482984860 group by v40)
select v40, v5 from aggJoin1430329807491189867 join aggView2458803366674959710 using(v40));
create or replace view aggJoin7251887194787174408 as (
with aggView3878723799885768271 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7794132380537501809 join aggView3878723799885768271 using(v5));
create or replace view aggJoin6333427318677551764 as (
with aggView6273263386829111672 as (select v40 from aggJoin7251887194787174408 group by v40)
select v40, v52 as v52 from aggJoin3165484397874406848 join aggView6273263386829111672 using(v40));
create or replace view aggJoin1477147525080950297 as (
with aggView8393425553354750628 as (select v40, MIN(v52) as v52 from aggJoin6333427318677551764 group by v40,v52)
select v41, v52 from aggView5725655701918725366 join aggView8393425553354750628 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin1477147525080950297;
