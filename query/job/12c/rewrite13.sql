create or replace view aggJoin1567555474623684494 as (
with aggView1955402352398113856 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView1955402352398113856 where mc.company_id=aggView1955402352398113856.v1);
create or replace view aggJoin3681667779558419770 as (
with aggView6213724810168337827 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1567555474623684494 join aggView6213724810168337827 using(v8));
create or replace view aggJoin7629181979641458766 as (
with aggView5444689827051203916 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView5444689827051203916 where mi_idx.info_type_id=aggView5444689827051203916.v26 and info>'7.0');
create or replace view aggJoin1194078144106832742 as (
with aggView8723494749717007787 as (select v29, MIN(v27) as v42 from aggJoin7629181979641458766 group by v29)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView8723494749717007787 where t.id=aggView8723494749717007787.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin970254796601119533 as (
with aggView2055963852268884951 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin1194078144106832742 group by v29,v42)
select movie_id as v29, info_type_id as v21, info as v22, v42, v43 from movie_info as mi, aggView2055963852268884951 where mi.movie_id=aggView2055963852268884951.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin7131906327142734946 as (
with aggView4521211083825373211 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v42, v43 from aggJoin970254796601119533 join aggView4521211083825373211 using(v21));
create or replace view aggJoin9204535369778049017 as (
with aggView2097230861872457265 as (select v29, MIN(v42) as v42, MIN(v43) as v43 from aggJoin7131906327142734946 group by v29,v42,v43)
select v41 as v41, v42, v43 from aggJoin3681667779558419770 join aggView2097230861872457265 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin9204535369778049017;
