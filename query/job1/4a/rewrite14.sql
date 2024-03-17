create or replace view aggView3467920189039335481 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin528998023612183060 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3467920189039335481 where mi_idx.movie_id=aggView3467920189039335481.v14 and info>'5.0';
create or replace view aggView4014686792250054486 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5019971969190799212 as select movie_id as v14 from movie_keyword as mk, aggView4014686792250054486 where mk.keyword_id=aggView4014686792250054486.v3;
create or replace view aggView4063556007456425087 as select v14 from aggJoin5019971969190799212 group by v14;
create or replace view aggJoin6752986839859445095 as select v1, v9, v27 as v27 from aggJoin528998023612183060 join aggView4063556007456425087 using(v14);
create or replace view aggView5033268109838095420 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8386971840321979001 as select v9, v27 from aggJoin6752986839859445095 join aggView5033268109838095420 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin8386971840321979001;
