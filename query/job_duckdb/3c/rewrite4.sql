create or replace view aggView5943665862594641091 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8931862950842790683 as select id as v12, title as v13, production_year as v16 from title as t, aggView5943665862594641091 where t.id=aggView5943665862594641091.v12 and production_year>1990;
create or replace view aggView56121912038090381 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin924868378430090574 as select movie_id as v12 from movie_keyword as mk, aggView56121912038090381 where mk.keyword_id=aggView56121912038090381.v1;
create or replace view aggView7784869618119799410 as select v12, MIN(v13) as v24 from aggJoin8931862950842790683 group by v12;
create or replace view aggJoin5901146278274943721 as select v24 from aggJoin924868378430090574 join aggView7784869618119799410 using(v12);
select MIN(v24) as v24 from aggJoin5901146278274943721;
