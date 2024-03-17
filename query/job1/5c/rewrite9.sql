create or replace view aggView8096528489091804698 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin481156741427937150 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8096528489091804698 where mi.movie_id=aggView8096528489091804698.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8621865456584450232 as select id as v3 from info_type as it;
create or replace view aggJoin3123781774149994663 as select v15, v13, v27 from aggJoin481156741427937150 join aggView8621865456584450232 using(v3);
create or replace view aggView4135795277824871842 as select v15, MIN(v27) as v27 from aggJoin3123781774149994663 group by v15;
create or replace view aggJoin8585500122749620240 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4135795277824871842 where mc.movie_id=aggView4135795277824871842.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView808356036907502015 as select v1, MIN(v27) as v27 from aggJoin8585500122749620240 group by v1;
create or replace view aggJoin8705530423135201341 as select kind as v2, v27 from company_type as ct, aggView808356036907502015 where ct.id=aggView808356036907502015.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin8705530423135201341;
