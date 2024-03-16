create or replace view aggView3059383359468490845 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin621495670362622998 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3059383359468490845 where mi.movie_id=aggView3059383359468490845.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView921529015514994213 as select id as v3 from info_type as it;
create or replace view aggJoin8219912925440727738 as select v15, v13, v27 from aggJoin621495670362622998 join aggView921529015514994213 using(v3);
create or replace view aggView5003260389295372536 as select v15, MIN(v27) as v27 from aggJoin8219912925440727738 group by v15;
create or replace view aggJoin532294317945040962 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView5003260389295372536 where mc.movie_id=aggView5003260389295372536.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5452365984846630019 as select v1, MIN(v27) as v27 from aggJoin532294317945040962 group by v1;
create or replace view aggJoin1716690241490680783 as select kind as v2, v27 from company_type as ct, aggView5452365984846630019 where ct.id=aggView5452365984846630019.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin1716690241490680783;
