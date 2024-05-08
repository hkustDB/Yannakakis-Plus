create or replace view aggView9211151439487032154 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6251714428855119031 as select movie_id as v14 from movie_keyword as mk, aggView9211151439487032154 where mk.keyword_id=aggView9211151439487032154.v3;
create or replace view aggView4982172292955529947 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5234519851776718145 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4982172292955529947 where mi_idx.info_type_id=aggView4982172292955529947.v1 and info>'9.0';
create or replace view aggView4224895203386400320 as select v14, MIN(v9) as v26 from aggJoin5234519851776718145 group by v14;
create or replace view aggJoin6131109869563835107 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4224895203386400320 where t.id=aggView4224895203386400320.v14 and production_year>2010;
create or replace view aggView2969124495542736761 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin6131109869563835107 group by v14;
create or replace view aggJoin8673776137396735705 as select v26, v27 from aggJoin6251714428855119031 join aggView2969124495542736761 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8673776137396735705;
