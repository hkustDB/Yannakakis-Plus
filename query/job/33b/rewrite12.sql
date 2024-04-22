create or replace view aggJoin133032931444221559 as (
with aggView1036265071221112359 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1036265071221112359 where mc1.company_id=aggView1036265071221112359.v1);
create or replace view aggJoin6582816288467620897 as (
with aggView4912465956894512658 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView4912465956894512658 where mc2.company_id=aggView4912465956894512658.v8);
create or replace view aggJoin951049751499041243 as (
with aggView1075362461061090490 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1075362461061090490 where mi_idx1.info_type_id=aggView1075362461061090490.v15);
create or replace view aggJoin262418478173421633 as (
with aggView2717167553009156878 as (select v61, MIN(v74) as v74 from aggJoin6582816288467620897 group by v61,v74)
select movie_id as v61, info_type_id as v17, info as v43, v74 from movie_info_idx as mi_idx2, aggView2717167553009156878 where mi_idx2.movie_id=aggView2717167553009156878.v61 and info<'3.0');
create or replace view aggJoin6438137431981364619 as (
with aggView4747087215122865440 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView4747087215122865440 where ml.link_type_id=aggView4747087215122865440.v23);
create or replace view aggJoin3839232286277045604 as (
with aggView7942281228937321097 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v74 from aggJoin262418478173421633 join aggView7942281228937321097 using(v17));
create or replace view aggJoin7397093481076378111 as (
with aggView2102663452584894649 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView2102663452584894649 where t2.kind_id=aggView2102663452584894649.v21 and production_year= 2007);
create or replace view aggJoin1892246185944152334 as (
with aggView5876497067429143058 as (select v61, MIN(v62) as v78 from aggJoin7397093481076378111 group by v61)
select v61, v43, v74 as v74, v78 from aggJoin3839232286277045604 join aggView5876497067429143058 using(v61));
create or replace view aggJoin2542356126682318141 as (
with aggView3407933399828024893 as (select v61, MIN(v74) as v74, MIN(v78) as v78, MIN(v43) as v76 from aggJoin1892246185944152334 group by v61,v74,v78)
select v49, v74, v78, v76 from aggJoin6438137431981364619 join aggView3407933399828024893 using(v61));
create or replace view aggJoin1704224959322620048 as (
with aggView3542623863381731424 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView3542623863381731424 where t1.kind_id=aggView3542623863381731424.v19);
create or replace view aggJoin8776161239363914571 as (
with aggView7287953158321974516 as (select v49, MIN(v50) as v77 from aggJoin1704224959322620048 group by v49)
select v49, v38, v77 from aggJoin951049751499041243 join aggView7287953158321974516 using(v49));
create or replace view aggJoin2411090520358938750 as (
with aggView5893875431910834940 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin8776161239363914571 group by v49,v77)
select v49, v74 as v74, v78 as v78, v76 as v76, v77, v75 from aggJoin2542356126682318141 join aggView5893875431910834940 using(v49));
create or replace view aggJoin4590777687183548187 as (
with aggView266568232181864461 as (select v49, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76, MIN(v77) as v77, MIN(v75) as v75 from aggJoin2411090520358938750 group by v49,v74,v78,v75,v76,v77)
select v73 as v73, v74, v78, v76, v77, v75 from aggJoin133032931444221559 join aggView266568232181864461 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4590777687183548187;
