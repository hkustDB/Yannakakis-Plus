create or replace view aggView7724767288628788415 as select id as v40, title as v41 from title as t where production_year>1990;
create or replace view aggJoin8380276400197083860 as (
with aggView6368285205023276810 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView6368285205023276810 where mc.company_id=aggView6368285205023276810.v13);
create or replace view aggJoin1358114059470044047 as (
with aggView3148634769703350657 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView3148634769703350657 where mi.info_type_id=aggView3148634769703350657.v22 and note LIKE '%internet%');
create or replace view aggJoin2384139209045011639 as (
with aggView960405932927047 as (select id as v20 from company_type as ct)
select v40 from aggJoin8380276400197083860 join aggView960405932927047 using(v20));
create or replace view aggJoin3100588457224574237 as (
with aggView4538679124901061457 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4538679124901061457 where mk.keyword_id=aggView4538679124901061457.v24);
create or replace view aggJoin2834149664151341500 as (
with aggView4817572119897732720 as (select v40 from aggJoin3100588457224574237 group by v40)
select v40, v36 from aggJoin1358114059470044047 join aggView4817572119897732720 using(v40));
create or replace view aggJoin2732167841646504470 as (
with aggView4204717541101237065 as (select v40 from aggJoin2834149664151341500 group by v40)
select v40 from aggJoin2384139209045011639 join aggView4204717541101237065 using(v40));
create or replace view aggJoin8120227922197930890 as (
with aggView6463696637223134204 as (select v40 from aggJoin2732167841646504470 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView6463696637223134204 where aka_t.movie_id=aggView6463696637223134204.v40);
create or replace view aggView1721489931137113721 as select v40, v3 from aggJoin8120227922197930890 group by v40,v3;
create or replace view aggJoin38718528257620172 as (
with aggView8279962789383464145 as (select v40, MIN(v41) as v53 from aggView7724767288628788415 group by v40)
select v3, v53 from aggView1721489931137113721 join aggView8279962789383464145 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin38718528257620172;
