create or replace view aggView961130112373611164 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin682490703920678513 as (
with aggView7314039165164489889 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7314039165164489889 where mk.keyword_id=aggView7314039165164489889.v33);
create or replace view aggJoin18206549730645852 as (
with aggView8627433560295524560 as (select v11 from aggJoin682490703920678513 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView8627433560295524560 where t.id=aggView8627433560295524560.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView5156458519623544031 as select v11, v44 from aggJoin18206549730645852 group by v11,v44;
create or replace view aggJoin6850461243116979158 as (
with aggView1832007017211925817 as (select v2, MIN(v3) as v55 from aggView961130112373611164 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView1832007017211925817 where ci.person_id=aggView1832007017211925817.v2);
create or replace view aggJoin3703806655459745711 as (
with aggView4370119559702040871 as (select id as v2 from name as n)
select v11, v55 from aggJoin6850461243116979158 join aggView4370119559702040871 using(v2));
create or replace view aggJoin2387939436186306095 as (
with aggView5553055150154996106 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5553055150154996106 where mc.company_id=aggView5553055150154996106.v28);
create or replace view aggJoin1761097840292829161 as (
with aggView7569696866025351263 as (select v11 from aggJoin2387939436186306095 group by v11)
select v11, v55 as v55 from aggJoin3703806655459745711 join aggView7569696866025351263 using(v11));
create or replace view aggJoin6803139751647705926 as (
with aggView7110574875789158764 as (select v11, MIN(v55) as v55 from aggJoin1761097840292829161 group by v11,v55)
select v44, v55 from aggView5156458519623544031 join aggView7110574875789158764 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin6803139751647705926;
