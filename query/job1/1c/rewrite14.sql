create or replace view aggView6019297852195782426 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin3953784252398031381 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6019297852195782426 where mc.movie_id=aggView6019297852195782426.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1120714096694105461 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8709921737785337884 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1120714096694105461 where mi_idx.info_type_id=aggView1120714096694105461.v3;
create or replace view aggView1913947962576464388 as select v15 from aggJoin8709921737785337884 group by v15;
create or replace view aggJoin5500641398693150995 as select v1, v9, v28 as v28, v29 as v29 from aggJoin3953784252398031381 join aggView1913947962576464388 using(v15);
create or replace view aggView642668498198275756 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin203277009009226277 as select v9, v28, v29 from aggJoin5500641398693150995 join aggView642668498198275756 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin203277009009226277;
