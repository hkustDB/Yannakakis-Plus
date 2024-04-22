create or replace view aggView7016063935693360134 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView5926885123320731271 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin6264032290301518255 as (
with aggView982294175482807891 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView982294175482807891 where t2.kind_id=aggView982294175482807891.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView9168131827563591464 as select v61, v62 from aggJoin6264032290301518255 group by v61,v62;
create or replace view aggJoin3515344395913162053 as (
with aggView9157607888239647943 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView9157607888239647943 where t1.kind_id=aggView9157607888239647943.v19);
create or replace view aggView5414889329503950002 as select v49, v50 from aggJoin3515344395913162053 group by v49,v50;
create or replace view aggJoin4810671658654112005 as (
with aggView5917184820040677019 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5917184820040677019 where mi_idx2.info_type_id=aggView5917184820040677019.v17 and info<'3.0');
create or replace view aggView5340403652546742672 as select v61, v43 from aggJoin4810671658654112005 group by v61,v43;
create or replace view aggJoin6250479254733921101 as (
with aggView2577393404796705905 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2577393404796705905 where mi_idx1.info_type_id=aggView2577393404796705905.v15);
create or replace view aggView5670886978804659746 as select v49, v38 from aggJoin6250479254733921101 group by v49,v38;
create or replace view aggJoin4100990220752519317 as (
with aggView868084404802088951 as (select v61, MIN(v43) as v76 from aggView5340403652546742672 group by v61)
select movie_id as v61, company_id as v8, v76 from movie_companies as mc2, aggView868084404802088951 where mc2.movie_id=aggView868084404802088951.v61);
create or replace view aggJoin723215405568832104 as (
with aggView7294333996454747562 as (select v8, MIN(v9) as v74 from aggView7016063935693360134 group by v8)
select v61, v76 as v76, v74 from aggJoin4100990220752519317 join aggView7294333996454747562 using(v8));
create or replace view aggJoin3209153205207139983 as (
with aggView6573381948286866307 as (select v1, MIN(v2) as v73 from aggView5926885123320731271 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView6573381948286866307 where mc1.company_id=aggView6573381948286866307.v1);
create or replace view aggJoin1129709186125584675 as (
with aggView8472479875045419342 as (select v49, MIN(v50) as v77 from aggView5414889329503950002 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77 from movie_link as ml, aggView8472479875045419342 where ml.movie_id=aggView8472479875045419342.v49);
create or replace view aggJoin53290517959334751 as (
with aggView4031855408351013452 as (select v61, MIN(v62) as v78 from aggView9168131827563591464 group by v61)
select v61, v76 as v76, v74 as v74, v78 from aggJoin723215405568832104 join aggView4031855408351013452 using(v61));
create or replace view aggJoin5759199809803077710 as (
with aggView5851766017218418811 as (select v49, MIN(v73) as v73 from aggJoin3209153205207139983 group by v49,v73)
select v49, v38, v73 from aggView5670886978804659746 join aggView5851766017218418811 using(v49));
create or replace view aggJoin5901941106062172591 as (
with aggView5120472073162878920 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v77 from aggJoin1129709186125584675 join aggView5120472073162878920 using(v23));
create or replace view aggJoin6333004985460214758 as (
with aggView1521264683831587420 as (select v61, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78 from aggJoin53290517959334751 group by v61,v74,v76,v78)
select v49, v77 as v77, v76, v74, v78 from aggJoin5901941106062172591 join aggView1521264683831587420 using(v61));
create or replace view aggJoin4863884422074498551 as (
with aggView6021390704150750907 as (select v49, MIN(v77) as v77, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78 from aggJoin6333004985460214758 group by v49,v77,v74,v76,v78)
select v38, v73 as v73, v77, v76, v74, v78 from aggJoin5759199809803077710 join aggView6021390704150750907 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v38) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4863884422074498551;
