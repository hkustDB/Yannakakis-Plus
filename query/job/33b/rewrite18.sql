create or replace view aggView4767926328075958278 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView314076952782900835 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin4508696572455466231 as (
with aggView8309440562548356906 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8309440562548356906 where mi_idx1.info_type_id=aggView8309440562548356906.v15);
create or replace view aggView9056228824289337375 as select v49, v38 from aggJoin4508696572455466231 group by v49,v38;
create or replace view aggJoin231209378987933977 as (
with aggView8062580841662861396 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8062580841662861396 where mi_idx2.info_type_id=aggView8062580841662861396.v17 and info<'3.0');
create or replace view aggView626870492914885975 as select v61, v43 from aggJoin231209378987933977 group by v61,v43;
create or replace view aggJoin5202938602766809384 as (
with aggView5891297176562098864 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView5891297176562098864 where t1.kind_id=aggView5891297176562098864.v19);
create or replace view aggView1020576735225120518 as select v50, v49 from aggJoin5202938602766809384 group by v50,v49;
create or replace view aggJoin9011729879353303003 as (
with aggView6758088195698098243 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView6758088195698098243 where t2.kind_id=aggView6758088195698098243.v21 and production_year= 2007);
create or replace view aggView6364456510915681626 as select v62, v61 from aggJoin9011729879353303003 group by v62,v61;
create or replace view aggJoin4250344184142335242 as (
with aggView1201318307553453917 as (select v8, MIN(v9) as v74 from aggView4767926328075958278 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView1201318307553453917 where mc2.company_id=aggView1201318307553453917.v8);
create or replace view aggJoin7379036058051927856 as (
with aggView5691851439197367116 as (select v1, MIN(v2) as v73 from aggView314076952782900835 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView5691851439197367116 where mc1.company_id=aggView5691851439197367116.v1);
create or replace view aggJoin6752684967097011632 as (
with aggView1939489716396200736 as (select v61, MIN(v43) as v76 from aggView626870492914885975 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView1939489716396200736 where ml.linked_movie_id=aggView1939489716396200736.v61);
create or replace view aggJoin1944527040497082085 as (
with aggView4540645809669403393 as (select v61, MIN(v62) as v78 from aggView6364456510915681626 group by v61)
select v49, v61, v23, v76 as v76, v78 from aggJoin6752684967097011632 join aggView4540645809669403393 using(v61));
create or replace view aggJoin8530496347835265852 as (
with aggView7776615420932440671 as (select v49, MIN(v73) as v73 from aggJoin7379036058051927856 group by v49,v73)
select v50, v49, v73 from aggView1020576735225120518 join aggView7776615420932440671 using(v49));
create or replace view aggJoin6398072415046473132 as (
with aggView3039481816546651737 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin8530496347835265852 group by v49,v73)
select v49, v61, v23, v76 as v76, v78 as v78, v73, v77 from aggJoin1944527040497082085 join aggView3039481816546651737 using(v49));
create or replace view aggJoin176601640946271591 as (
with aggView5854838634394232336 as (select v61, MIN(v74) as v74 from aggJoin4250344184142335242 group by v61,v74)
select v49, v23, v76 as v76, v78 as v78, v73 as v73, v77 as v77, v74 from aggJoin6398072415046473132 join aggView5854838634394232336 using(v61));
create or replace view aggJoin718916961094639216 as (
with aggView8121737816917495396 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v76, v78, v73, v77, v74 from aggJoin176601640946271591 join aggView8121737816917495396 using(v23));
create or replace view aggJoin6538200575215592857 as (
with aggView302975437606162834 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v73) as v73, MIN(v77) as v77, MIN(v74) as v74 from aggJoin718916961094639216 group by v49,v74,v78,v76,v73,v77)
select v38, v76, v78, v73, v77, v74 from aggView9056228824289337375 join aggView302975437606162834 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v38) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6538200575215592857;
