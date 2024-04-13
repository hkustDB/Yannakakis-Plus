create or replace view aggView3323700168374031464 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4018525062105632189 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3323700168374031464 where mc.company_type_id=aggView3323700168374031464.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView715469732341510296 as select v15 from aggJoin4018525062105632189 group by v15;
create or replace view aggJoin8893278083027276780 as select id as v15, title as v16, production_year as v19 from title as t, aggView715469732341510296 where t.id=aggView715469732341510296.v15 and production_year>2005;
create or replace view aggView5870789653290938611 as select v15, MIN(v16) as v27 from aggJoin8893278083027276780 group by v15;
create or replace view aggJoin7140015257973716715 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView5870789653290938611 where mi.movie_id=aggView5870789653290938611.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5459465110054611642 as select id as v3 from info_type as it;
create or replace view aggJoin6244691922090345280 as select v27 from aggJoin7140015257973716715 join aggView5459465110054611642 using(v3);
select MIN(v27) as v27 from aggJoin6244691922090345280;
