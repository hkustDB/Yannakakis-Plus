create or replace view aggView6906539516280699194 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView1542168423901970427 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin832450292513885630 as (
with aggView3496475420552584655 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView3496475420552584655 where t1.kind_id=aggView3496475420552584655.v19);
create or replace view aggView4424858905387087963 as select v49, v50 from aggJoin832450292513885630 group by v49,v50;
create or replace view aggJoin8444649044732753520 as (
with aggView8469083415769661289 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView8469083415769661289 where t2.kind_id=aggView8469083415769661289.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView1248646657330912611 as select v61, v62 from aggJoin8444649044732753520 group by v61,v62;
create or replace view aggJoin5924348989222339171 as (
with aggView282721527537563387 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView282721527537563387 where mi_idx2.info_type_id=aggView282721527537563387.v17 and info<'3.0');
create or replace view aggView5183031123557636508 as select v61, v43 from aggJoin5924348989222339171 group by v61,v43;
create or replace view aggJoin5413923997807020379 as (
with aggView7342812737502419818 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7342812737502419818 where mi_idx1.info_type_id=aggView7342812737502419818.v15);
create or replace view aggView1525433279018466013 as select v49, v38 from aggJoin5413923997807020379 group by v49,v38;
create or replace view aggJoin6405293909504592962 as (
with aggView7384067421501639398 as (select v8, MIN(v9) as v74 from aggView6906539516280699194 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView7384067421501639398 where mc2.company_id=aggView7384067421501639398.v8);
create or replace view aggJoin6663520113425842714 as (
with aggView7887316354687392079 as (select v1, MIN(v2) as v73 from aggView1542168423901970427 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView7887316354687392079 where mc1.company_id=aggView7887316354687392079.v1);
create or replace view aggJoin5391320841511837428 as (
with aggView917468282929117082 as (select v49, MIN(v50) as v77 from aggView4424858905387087963 group by v49)
select v49, v73 as v73, v77 from aggJoin6663520113425842714 join aggView917468282929117082 using(v49));
create or replace view aggJoin3543638599402171482 as (
with aggView6270420790707070784 as (select v49, MIN(v73) as v73, MIN(v77) as v77 from aggJoin5391320841511837428 group by v49,v77,v73)
select v49, v38, v73, v77 from aggView1525433279018466013 join aggView6270420790707070784 using(v49));
create or replace view aggJoin545179751431544324 as (
with aggView5079064457700228101 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v38) as v75 from aggJoin3543638599402171482 group by v49,v77,v73)
select linked_movie_id as v61, link_type_id as v23, v73, v77, v75 from movie_link as ml, aggView5079064457700228101 where ml.movie_id=aggView5079064457700228101.v49);
create or replace view aggJoin5596954339361187624 as (
with aggView189394159558160693 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v77, v75 from aggJoin545179751431544324 join aggView189394159558160693 using(v23));
create or replace view aggJoin1784713991376621214 as (
with aggView7971779877333381117 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin5596954339361187624 group by v61,v75,v77,v73)
select v61, v62, v73, v77, v75 from aggView1248646657330912611 join aggView7971779877333381117 using(v61));
create or replace view aggJoin6381013981513228398 as (
with aggView6245261061037084179 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v62) as v78 from aggJoin1784713991376621214 group by v61,v75,v77,v73)
select v61, v43, v73, v77, v75, v78 from aggView5183031123557636508 join aggView6245261061037084179 using(v61));
create or replace view aggJoin3392739827287146089 as (
with aggView366530395257639737 as (select v61, MIN(v74) as v74 from aggJoin6405293909504592962 group by v61,v74)
select v43, v73 as v73, v77 as v77, v75 as v75, v78 as v78, v74 from aggJoin6381013981513228398 join aggView366530395257639737 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3392739827287146089;
