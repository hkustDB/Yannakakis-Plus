create or replace view aggView4987248258229246044 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin114620257314979236 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4987248258229246044 where mi_idx.info_type_id=aggView4987248258229246044.v3;
create or replace view aggView4967066912643381256 as select v15 from aggJoin114620257314979236 group by v15;
create or replace view aggJoin935844842607533985 as select id as v15, title as v16, production_year as v19 from title as t, aggView4967066912643381256 where t.id=aggView4967066912643381256.v15 and production_year>2000;
create or replace view aggView8825236318001687423 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6542651242449795703 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8825236318001687423 where mc.company_type_id=aggView8825236318001687423.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1616193710476391384 as select v15, MIN(v9) as v27 from aggJoin6542651242449795703 group by v15;
create or replace view aggJoin4614797379554901353 as select v16, v19, v27 from aggJoin935844842607533985 join aggView1616193710476391384 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4614797379554901353;
