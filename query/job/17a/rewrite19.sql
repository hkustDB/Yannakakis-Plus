create or replace view aggJoin1452862523126435130 as (
with aggView951466300731367179 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView951466300731367179 where ci.person_id=aggView951466300731367179.v26);
create or replace view aggJoin15499638829572596 as (
with aggView7874546193846642205 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView7874546193846642205 where mc.company_id=aggView7874546193846642205.v20);
create or replace view aggJoin2416276884459161688 as (
with aggView1468520111629247084 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1468520111629247084 where mk.keyword_id=aggView1468520111629247084.v25);
create or replace view aggJoin5385064158407181409 as (
with aggView2363018292714957706 as (select v3 from aggJoin2416276884459161688 group by v3)
select v3, v47 as v47 from aggJoin1452862523126435130 join aggView2363018292714957706 using(v3));
create or replace view aggJoin8970076262295669227 as (
with aggView4426156202895719975 as (select v3 from aggJoin15499638829572596 group by v3)
select id as v3 from title as t, aggView4426156202895719975 where t.id=aggView4426156202895719975.v3);
create or replace view aggJoin7152753915793506019 as (
with aggView7563435777788355325 as (select v3 from aggJoin8970076262295669227 group by v3)
select v47 as v47 from aggJoin5385064158407181409 join aggView7563435777788355325 using(v3));
select MIN(v47) as v47 from aggJoin7152753915793506019;
