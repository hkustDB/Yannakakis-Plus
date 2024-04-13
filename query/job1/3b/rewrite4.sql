create or replace view aggView4201457136948111381 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin5764197997568107593 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4201457136948111381 where mi.movie_id=aggView4201457136948111381.v12 and info= 'Bulgaria';
create or replace view aggView2887751387195059077 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin493845104136811472 as select movie_id as v12 from movie_keyword as mk, aggView2887751387195059077 where mk.keyword_id=aggView2887751387195059077.v1;
create or replace view aggView5174647775570935078 as select v12 from aggJoin493845104136811472 group by v12;
create or replace view aggJoin7226413348557855770 as select v24 as v24 from aggJoin5764197997568107593 join aggView5174647775570935078 using(v12);
select MIN(v24) as v24 from aggJoin7226413348557855770;
