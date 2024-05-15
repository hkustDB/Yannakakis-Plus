create or replace view aggView6612463293305333592 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin4418107191764128187 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView6612463293305333592 where mi_idx.movie_id=aggView6612463293305333592.v14 and info>'5.0';
create or replace view aggView5931746349757639131 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8530418435125415753 as select v14, v9, v27 from aggJoin4418107191764128187 join aggView5931746349757639131 using(v1);
create or replace view aggView3510330119668585624 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin8530418435125415753 group by v14;
create or replace view aggJoin502679488670441758 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView3510330119668585624 where mk.movie_id=aggView3510330119668585624.v14;
create or replace view aggView8448590317819270524 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8428118746153327175 as select v27, v26 from aggJoin502679488670441758 join aggView8448590317819270524 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8428118746153327175;
