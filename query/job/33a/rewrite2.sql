create or replace view aggView565173738030918602 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView8657014555741245289 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin6433718349258321409 as (
with aggView1662414881721659486 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1662414881721659486 where t2.kind_id=aggView1662414881721659486.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView2106633284519079558 as select v61, v62 from aggJoin6433718349258321409 group by v61,v62;
create or replace view aggJoin260783349834294342 as (
with aggView4275905682370850501 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView4275905682370850501 where t1.kind_id=aggView4275905682370850501.v19);
create or replace view aggView809650542536056004 as select v49, v50 from aggJoin260783349834294342 group by v49,v50;
create or replace view aggJoin3803923604412786087 as (
with aggView2809810001493771324 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2809810001493771324 where mi_idx2.info_type_id=aggView2809810001493771324.v17 and info<'3.0');
create or replace view aggView355339741378034647 as select v61, v43 from aggJoin3803923604412786087 group by v61,v43;
create or replace view aggJoin1801374895132102197 as (
with aggView5929519399539003055 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5929519399539003055 where mi_idx1.info_type_id=aggView5929519399539003055.v15);
create or replace view aggView2148980035621422067 as select v49, v38 from aggJoin1801374895132102197 group by v49,v38;
create or replace view aggJoin6405941085119254041 as (
with aggView3551215182350408348 as (select v49, MIN(v38) as v75 from aggView2148980035621422067 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView3551215182350408348 where ml.movie_id=aggView3551215182350408348.v49);
create or replace view aggJoin409271463184574869 as (
with aggView6634728710569061562 as (select v8, MIN(v9) as v74 from aggView565173738030918602 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6634728710569061562 where mc2.company_id=aggView6634728710569061562.v8);
create or replace view aggJoin8452760215044277697 as (
with aggView5884878150273244703 as (select v1, MIN(v2) as v73 from aggView8657014555741245289 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView5884878150273244703 where mc1.company_id=aggView5884878150273244703.v1);
create or replace view aggJoin5974148499282978128 as (
with aggView5567281826479137430 as (select v61, MIN(v62) as v78 from aggView2106633284519079558 group by v61)
select v61, v74 as v74, v78 from aggJoin409271463184574869 join aggView5567281826479137430 using(v61));
create or replace view aggJoin450362743783590911 as (
with aggView3033910820086310602 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v75 from aggJoin6405941085119254041 join aggView3033910820086310602 using(v23));
create or replace view aggJoin3670479177221592925 as (
with aggView2563841310870477245 as (select v61, MIN(v74) as v74, MIN(v78) as v78 from aggJoin5974148499282978128 group by v61,v74,v78)
select v61, v43, v74, v78 from aggView355339741378034647 join aggView2563841310870477245 using(v61));
create or replace view aggJoin3511226002716808523 as (
with aggView1867950579896480784 as (select v61, MIN(v74) as v74, MIN(v78) as v78, MIN(v43) as v76 from aggJoin3670479177221592925 group by v61,v74,v78)
select v49, v75 as v75, v74, v78, v76 from aggJoin450362743783590911 join aggView1867950579896480784 using(v61));
create or replace view aggJoin1894899049578802477 as (
with aggView8800901552901885848 as (select v49, MIN(v75) as v75, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin3511226002716808523 group by v49,v75,v74,v76,v78)
select v49, v50, v75, v74, v78, v76 from aggView809650542536056004 join aggView8800901552901885848 using(v49));
create or replace view aggJoin4088032459176186666 as (
with aggView3390184746215891388 as (select v49, MIN(v73) as v73 from aggJoin8452760215044277697 group by v49,v73)
select v50, v75 as v75, v74 as v74, v78 as v78, v76 as v76, v73 from aggJoin1894899049578802477 join aggView3390184746215891388 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin4088032459176186666;
