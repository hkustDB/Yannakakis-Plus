create or replace view aggView1543836311933903971 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2751203185193283793 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1543836311933903971 where mi.movie_id=aggView1543836311933903971.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5036086077739435433 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2058855613396827421 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5036086077739435433 where mc.company_type_id=aggView5036086077739435433.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8213354636448543456 as select v15 from aggJoin2058855613396827421 group by v15;
create or replace view aggJoin4553457189680262831 as select v3, v13, v27 as v27 from aggJoin2751203185193283793 join aggView8213354636448543456 using(v15);
create or replace view aggView8503941219361409290 as select id as v3 from info_type as it;
create or replace view aggJoin6219279130172052832 as select v13, v27 from aggJoin4553457189680262831 join aggView8503941219361409290 using(v3);
select MIN(v27) as v27 from aggJoin6219279130172052832;
