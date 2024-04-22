create or replace view aggView62602594131920578 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggView1015459134251544862 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3135500848143828086 as (
with aggView486606524913394527 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView486606524913394527 where mi_idx.info_type_id=aggView486606524913394527.v26);
create or replace view aggJoin9055637991712102619 as (
with aggView5845868487920320250 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView5845868487920320250 where mi.info_type_id=aggView5845868487920320250.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin1567499953084203077 as (
with aggView1285024346552869696 as (select v29 from aggJoin9055637991712102619 group by v29)
select v29, v27 from aggJoin3135500848143828086 join aggView1285024346552869696 using(v29));
create or replace view aggJoin6855349625281123447 as (
with aggView2645608217819251321 as (select v29, v27 from aggJoin1567499953084203077 group by v29,v27)
select v29, v27 from aggView2645608217819251321 where v27>'7.0');
create or replace view aggJoin9209012694699583838 as (
with aggView7393582675635756510 as (select v29, MIN(v30) as v43 from aggView62602594131920578 group by v29)
select movie_id as v29, company_id as v1, company_type_id as v8, v43 from movie_companies as mc, aggView7393582675635756510 where mc.movie_id=aggView7393582675635756510.v29);
create or replace view aggJoin1601570245272830409 as (
with aggView217132029440076691 as (select v1, MIN(v2) as v41 from aggView1015459134251544862 group by v1)
select v29, v8, v43 as v43, v41 from aggJoin9209012694699583838 join aggView217132029440076691 using(v1));
create or replace view aggJoin1888792414087352121 as (
with aggView4631241096142796757 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v43, v41 from aggJoin1601570245272830409 join aggView4631241096142796757 using(v8));
create or replace view aggJoin8157245716191447267 as (
with aggView2236556698669218717 as (select v29, MIN(v43) as v43, MIN(v41) as v41 from aggJoin1888792414087352121 group by v29,v41,v43)
select v27, v43, v41 from aggJoin6855349625281123447 join aggView2236556698669218717 using(v29));
select MIN(v41) as v41,MIN(v27) as v42,MIN(v43) as v43 from aggJoin8157245716191447267;
