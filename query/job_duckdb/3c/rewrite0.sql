create or replace view aggView6628333771428999786 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2801367635670147185 as select movie_id as v12 from movie_keyword as mk, aggView6628333771428999786 where mk.keyword_id=aggView6628333771428999786.v1;
create or replace view aggView6463899710915892789 as select v12 from aggJoin2801367635670147185 group by v12;
create or replace view aggJoin6001508985720220889 as select movie_id as v12, info as v7 from movie_info as mi, aggView6463899710915892789 where mi.movie_id=aggView6463899710915892789.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4168807183719851966 as select v12 from aggJoin6001508985720220889 group by v12;
create or replace view aggJoin3671471580163410298 as select title as v13, production_year as v16 from title as t, aggView4168807183719851966 where t.id=aggView4168807183719851966.v12 and production_year>1990;
create or replace view aggView293227135816239190 as select v13 from aggJoin3671471580163410298;
select MIN(v13) as v24 from aggView293227135816239190;
