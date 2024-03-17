create or replace view aggView6571537457630070779 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2406051291481715908 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView6571537457630070779 where mc.movie_id=aggView6571537457630070779.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2305930075068371929 as select id as v3 from info_type as it;
create or replace view aggJoin8104212898580095149 as select movie_id as v15, info as v13 from movie_info as mi, aggView2305930075068371929 where mi.info_type_id=aggView2305930075068371929.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4032252791131237672 as select v15 from aggJoin8104212898580095149 group by v15;
create or replace view aggJoin3704050954603721079 as select v1, v9, v27 as v27 from aggJoin2406051291481715908 join aggView4032252791131237672 using(v15);
create or replace view aggView3031709757332363748 as select v1, MIN(v27) as v27 from aggJoin3704050954603721079 group by v1;
create or replace view aggJoin5196145331803459600 as select kind as v2, v27 from company_type as ct, aggView3031709757332363748 where ct.id=aggView3031709757332363748.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin5196145331803459600;
