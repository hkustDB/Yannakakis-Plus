create or replace view aggView4552645548327500971 as select id as v3 from info_type as it;
create or replace view aggJoin4236511208821089055 as select movie_id as v15, info as v13 from movie_info as mi, aggView4552645548327500971 where mi.info_type_id=aggView4552645548327500971.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView3177710822479879193 as select v15 from aggJoin4236511208821089055 group by v15;
create or replace view aggJoin3966778571485956766 as select id as v15, title as v16 from title as t, aggView3177710822479879193 where t.id=aggView3177710822479879193.v15 and production_year>2005;
create or replace view aggView8132714261829537973 as select v15, MIN(v16) as v27 from aggJoin3966778571485956766 group by v15;
create or replace view aggJoin6002336270956493387 as select company_type_id as v1, v27 from movie_companies as mc, aggView8132714261829537973 where mc.movie_id=aggView8132714261829537973.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6931449401016749468 as select v1, MIN(v27) as v27 from aggJoin6002336270956493387 group by v1;
create or replace view aggJoin3999818895270361431 as select v27 from company_type as ct, aggView6931449401016749468 where ct.id=aggView6931449401016749468.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin3999818895270361431;
