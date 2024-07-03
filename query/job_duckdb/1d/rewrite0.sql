create or replace view aggView6639986913466668283 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin487037512233515385 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6639986913466668283 where mi_idx.info_type_id=aggView6639986913466668283.v3;
create or replace view aggView8876589995771337965 as select v15 from aggJoin487037512233515385 group by v15;
create or replace view aggJoin7414754668122753728 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView8876589995771337965 where mc.movie_id=aggView8876589995771337965.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4575732290757492251 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin2052413593866239307 as select v1, v9, v28, v29 from aggJoin7414754668122753728 join aggView4575732290757492251 using(v15);
create or replace view aggView2125948663531284527 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6749950209218887009 as select v9, v28, v29 from aggJoin2052413593866239307 join aggView2125948663531284527 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6749950209218887009;
