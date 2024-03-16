create or replace view aggView8291619349312901595 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2654841948775834193 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8291619349312901595 where mi.movie_id=aggView8291619349312901595.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5225068595076936326 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4164379503604119525 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5225068595076936326 where mc.company_type_id=aggView5225068595076936326.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4472098039785193730 as select v15 from aggJoin4164379503604119525 group by v15;
create or replace view aggJoin7749082607261387305 as select v3, v13, v27 as v27 from aggJoin2654841948775834193 join aggView4472098039785193730 using(v15);
create or replace view aggView6235534164819790447 as select v3, MIN(v27) as v27 from aggJoin7749082607261387305 group by v3;
create or replace view aggJoin7072211034681212365 as select v27 from info_type as it, aggView6235534164819790447 where it.id=aggView6235534164819790447.v3;
select MIN(v27) as v27 from aggJoin7072211034681212365;
