create or replace view aggJoin2922432068177581682 as (
with aggView4333668265270746793 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4333668265270746793 where mc.company_id=aggView4333668265270746793.v28);
create or replace view aggJoin8685248160874817850 as (
with aggView9209223970030020814 as (select v11 from aggJoin2922432068177581682 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView9209223970030020814 where t.id=aggView9209223970030020814.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView1272882574212306287 as select v11, v44 from aggJoin8685248160874817850 group by v11,v44;
create or replace view aggJoin7241249576589481404 as (
with aggView3957560146757625719 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView3957560146757625719 where an.person_id=aggView3957560146757625719.v2);
create or replace view aggView663224981603999817 as select v2, v3 from aggJoin7241249576589481404 group by v2,v3;
create or replace view aggJoin4174657888482753274 as (
with aggView5699041396987302162 as (select v11, MIN(v44) as v56 from aggView1272882574212306287 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView5699041396987302162 where ci.movie_id=aggView5699041396987302162.v11);
create or replace view aggJoin5868042962524052811 as (
with aggView8360222818223513088 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8360222818223513088 where mk.keyword_id=aggView8360222818223513088.v33);
create or replace view aggJoin7229780233809553513 as (
with aggView1148077961766311068 as (select v11 from aggJoin5868042962524052811 group by v11)
select v2, v56 as v56 from aggJoin4174657888482753274 join aggView1148077961766311068 using(v11));
create or replace view aggJoin6460608794466244441 as (
with aggView9107462191741787117 as (select v2, MIN(v56) as v56 from aggJoin7229780233809553513 group by v2,v56)
select v3, v56 from aggView663224981603999817 join aggView9107462191741787117 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin6460608794466244441;
