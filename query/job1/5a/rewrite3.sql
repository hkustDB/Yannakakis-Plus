create or replace view aggView3018705300518946205 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8760137128357408778 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3018705300518946205 where mc.company_type_id=aggView3018705300518946205.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView326352162284787847 as select v15 from aggJoin8760137128357408778 group by v15;
create or replace view aggJoin7038209997886230669 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView326352162284787847 where mi.movie_id=aggView326352162284787847.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7638770938878689501 as select id as v3 from info_type as it;
create or replace view aggJoin8675017235707640464 as select v15, v13 from aggJoin7038209997886230669 join aggView7638770938878689501 using(v3);
create or replace view aggView3705338489103155649 as select v15 from aggJoin8675017235707640464 group by v15;
create or replace view aggJoin5224449479984817662 as select title as v16 from title as t, aggView3705338489103155649 where t.id=aggView3705338489103155649.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin5224449479984817662;
