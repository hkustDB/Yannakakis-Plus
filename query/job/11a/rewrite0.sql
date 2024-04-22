create or replace view aggView4228426411211897159 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3528776536740570868 as (
with aggView2476262365589506661 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2476262365589506661 where mk.keyword_id=aggView2476262365589506661.v22);
create or replace view aggJoin3806055885112706709 as (
with aggView7652340239810744110 as (select v24 from aggJoin3528776536740570868 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView7652340239810744110 where t.id=aggView7652340239810744110.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggView887497687682871513 as select v28, v24 from aggJoin3806055885112706709 group by v28,v24;
create or replace view aggJoin2032421583883655939 as (
with aggView5021808897522132192 as (select v17, MIN(v2) as v39 from aggView4228426411211897159 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5021808897522132192 where mc.company_id=aggView5021808897522132192.v17);
create or replace view aggJoin8464826195276907876 as (
with aggView475313340900726672 as (select v24, MIN(v28) as v41 from aggView887497687682871513 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView475313340900726672 where ml.movie_id=aggView475313340900726672.v24);
create or replace view aggJoin8102300881319410794 as (
with aggView1267176009706933253 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin2032421583883655939 join aggView1267176009706933253 using(v18));
create or replace view aggJoin4637642062158034237 as (
with aggView2189785130408155643 as (select v24, MIN(v39) as v39 from aggJoin8102300881319410794 group by v24,v39)
select v13, v41 as v41, v39 from aggJoin8464826195276907876 join aggView2189785130408155643 using(v24));
create or replace view aggJoin2655531095844052807 as (
with aggView1956320221600216916 as (select v13, MIN(v41) as v41, MIN(v39) as v39 from aggJoin4637642062158034237 group by v13,v39,v41)
select link as v14, v41, v39 from link_type as lt, aggView1956320221600216916 where lt.id=aggView1956320221600216916.v13 and link LIKE '%follow%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin2655531095844052807;
