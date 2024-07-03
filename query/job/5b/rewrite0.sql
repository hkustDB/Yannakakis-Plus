create or replace view aggView7630175670665327821 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2771699072927435892 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7630175670665327821 where mc.company_type_id=aggView7630175670665327821.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView947829490838680667 as select v15 from aggJoin2771699072927435892 group by v15;
create or replace view aggJoin1904692448264276874 as select id as v15, title as v16, production_year as v19 from title as t, aggView947829490838680667 where t.id=aggView947829490838680667.v15 and production_year>2010;
create or replace view aggView6431366092735639811 as select v15, MIN(v16) as v27 from aggJoin1904692448264276874 group by v15;
create or replace view aggJoin7990240719214031977 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6431366092735639811 where mi.movie_id=aggView6431366092735639811.v15 and info IN ('USA','America');
create or replace view aggView3278222379679347705 as select id as v3 from info_type as it;
create or replace view aggJoin130442782971165966 as select v13, v27 from aggJoin7990240719214031977 join aggView3278222379679347705 using(v3);
select MIN(v27) as v27 from aggJoin130442782971165966;
