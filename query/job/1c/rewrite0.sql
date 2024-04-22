create or replace view aggJoin3869452174807237116 as (
with aggView1643074972547844389 as (select production_year as v19, id as v15, title as v16 from title as t)
select v15, v16, v19 from aggView1643074972547844389 where v19>2010);
create or replace view aggJoin8853149054220592052 as (
with aggView6264161775476414865 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView6264161775476414865 where mi_idx.info_type_id=aggView6264161775476414865.v3);
create or replace view aggJoin1614515797464314173 as (
with aggView6064134014512746943 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6064134014512746943 where mc.company_type_id=aggView6064134014512746943.v1);
create or replace view aggJoin7288773535001480091 as (
with aggView581581760192616633 as (select v15 from aggJoin8853149054220592052 group by v15)
select v15, v9 from aggJoin1614515797464314173 join aggView581581760192616633 using(v15));
create or replace view aggJoin6876017782698900104 as (
with aggView2443078810754223141 as (select v15, v9 from aggJoin7288773535001480091 group by v15,v9)
select v15, v9 from aggView2443078810754223141 where v9 LIKE '%(co-production)%' and v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin7002611820186900237 as (
with aggView4449152231684883424 as (select v15, MIN(v9) as v27 from aggJoin6876017782698900104 group by v15)
select v16, v19, v27 from aggJoin3869452174807237116 join aggView4449152231684883424 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7002611820186900237;
