create or replace view aggJoin3961195140139353842 as (
with aggView1763377079697934109 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1763377079697934109 where mk.keyword_id=aggView1763377079697934109.v25);
create or replace view aggJoin8665189860451671681 as (
with aggView6583418098757238679 as (select v3 from aggJoin3961195140139353842 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView6583418098757238679 where ci.movie_id=aggView6583418098757238679.v3);
create or replace view aggJoin5523312343891027968 as (
with aggView1732287079043476799 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1732287079043476799 where mc.company_id=aggView1732287079043476799.v20);
create or replace view aggJoin1595926129824750493 as (
with aggView4350698545302950014 as (select v3 from aggJoin5523312343891027968 group by v3)
select id as v3 from title as t, aggView4350698545302950014 where t.id=aggView4350698545302950014.v3);
create or replace view aggJoin1493233355712905378 as (
with aggView7228440472117107352 as (select v3 from aggJoin1595926129824750493 group by v3)
select v26 from aggJoin8665189860451671681 join aggView7228440472117107352 using(v3));
create or replace view aggJoin847575928267467542 as (
with aggView9025598283178937843 as (select v26 from aggJoin1493233355712905378 group by v26)
select name as v27 from name as n, aggView9025598283178937843 where n.id=aggView9025598283178937843.v26 and name LIKE '%B%');
create or replace view aggView251794088924105246 as select v27 from aggJoin847575928267467542 group by v27;
select MIN(v27) as v47 from aggView251794088924105246;
