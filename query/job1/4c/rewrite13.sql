create or replace view aggView8555552036563584747 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin601128017415184633 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView8555552036563584747 where mi_idx.movie_id=aggView8555552036563584747.v14 and info>'2.0';
create or replace view aggView4789491423218401600 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1211500964508342014 as select movie_id as v14 from movie_keyword as mk, aggView4789491423218401600 where mk.keyword_id=aggView4789491423218401600.v3;
create or replace view aggView2952104145656254123 as select v14 from aggJoin1211500964508342014 group by v14;
create or replace view aggJoin6232474824670320117 as select v1, v9, v27 as v27 from aggJoin601128017415184633 join aggView2952104145656254123 using(v14);
create or replace view aggView5429403465894300396 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8263198216878202702 as select v9, v27 from aggJoin6232474824670320117 join aggView5429403465894300396 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin8263198216878202702;
