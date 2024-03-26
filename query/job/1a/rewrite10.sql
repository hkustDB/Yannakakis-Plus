create or replace view aggView3385585964207907090 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4942401751490504019 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3385585964207907090 where mi_idx.info_type_id=aggView3385585964207907090.v3;
create or replace view aggView8466460811823711682 as select v15 from aggJoin4942401751490504019 group by v15;
create or replace view aggJoin9067947166846210274 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView8466460811823711682 where mc.movie_id=aggView8466460811823711682.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView819923036399191105 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5553737346310852264 as select v15, v9 from aggJoin9067947166846210274 join aggView819923036399191105 using(v1);
create or replace view aggView4278627752921230278 as select v15, MIN(v9) as v27 from aggJoin5553737346310852264 group by v15;
create or replace view aggJoin7581205027277079058 as select title as v16, production_year as v19, v27 from title as t, aggView4278627752921230278 where t.id=aggView4278627752921230278.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7581205027277079058;
