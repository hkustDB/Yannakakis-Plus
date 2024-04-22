create or replace view aggView4585186158964684365 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView6594548109322652014 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin6459462989229973354 as (
with aggView3546739209295167391 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3546739209295167391 where mi_idx2.info_type_id=aggView3546739209295167391.v17);
create or replace view aggJoin4810928192881432828 as (
with aggView2462513137376256130 as (select v61, v43 from aggJoin6459462989229973354 group by v61,v43)
select v61, v43 from aggView2462513137376256130 where v43<'3.5');
create or replace view aggJoin4346266933094811776 as (
with aggView2417600159027727886 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView2417600159027727886 where t1.kind_id=aggView2417600159027727886.v19);
create or replace view aggView1166009742245683334 as select v50, v49 from aggJoin4346266933094811776 group by v50,v49;
create or replace view aggJoin3323806977240825045 as (
with aggView7777887801479594591 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7777887801479594591 where t2.kind_id=aggView7777887801479594591.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView6377596230756755974 as select v61, v62 from aggJoin3323806977240825045 group by v61,v62;
create or replace view aggJoin2572882474930733750 as (
with aggView8634678857352588962 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8634678857352588962 where mi_idx1.info_type_id=aggView8634678857352588962.v15);
create or replace view aggView8356887089902239016 as select v38, v49 from aggJoin2572882474930733750 group by v38,v49;
create or replace view aggJoin2358199675247902608 as (
with aggView4310524751133375017 as (select v1, MIN(v2) as v73 from aggView4585186158964684365 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView4310524751133375017 where mc1.company_id=aggView4310524751133375017.v1);
create or replace view aggJoin7933639455332633880 as (
with aggView2193812778278445307 as (select v49, MIN(v50) as v77 from aggView1166009742245683334 group by v49)
select v49, v73 as v73, v77 from aggJoin2358199675247902608 join aggView2193812778278445307 using(v49));
create or replace view aggJoin258624650306454001 as (
with aggView353491754740019393 as (select v8, MIN(v9) as v74 from aggView6594548109322652014 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView353491754740019393 where mc2.company_id=aggView353491754740019393.v8);
create or replace view aggJoin4121504592556716225 as (
with aggView2990107626040784975 as (select v49, MIN(v38) as v75 from aggView8356887089902239016 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView2990107626040784975 where ml.movie_id=aggView2990107626040784975.v49);
create or replace view aggJoin8653254273186819717 as (
with aggView4616044354301737417 as (select v61, MIN(v62) as v78 from aggView6377596230756755974 group by v61)
select v61, v43, v78 from aggJoin4810928192881432828 join aggView4616044354301737417 using(v61));
create or replace view aggJoin1801256099791382264 as (
with aggView8461340597877352895 as (select v49, MIN(v73) as v73, MIN(v77) as v77 from aggJoin7933639455332633880 group by v49,v77,v73)
select v61, v23, v75 as v75, v73, v77 from aggJoin4121504592556716225 join aggView8461340597877352895 using(v49));
create or replace view aggJoin4709239928267437784 as (
with aggView5781077391125298792 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v75, v73, v77 from aggJoin1801256099791382264 join aggView5781077391125298792 using(v23));
create or replace view aggJoin5274792866646170395 as (
with aggView1187647336096693436 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin4709239928267437784 group by v61,v77,v75,v73)
select v61, v74 as v74, v75, v73, v77 from aggJoin258624650306454001 join aggView1187647336096693436 using(v61));
create or replace view aggJoin514453337389760100 as (
with aggView1326740120995853643 as (select v61, MIN(v74) as v74, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin5274792866646170395 group by v61,v74,v77,v75,v73)
select v43, v78 as v78, v74, v75, v73, v77 from aggJoin8653254273186819717 join aggView1326740120995853643 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin514453337389760100;
