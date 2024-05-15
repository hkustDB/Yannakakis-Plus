create or replace view aggView7257141130901842710 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6613624218123187488 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7257141130901842710 where mi_idx.info_type_id=aggView7257141130901842710.v1 and info>'5.0';
create or replace view aggView371925758220044787 as select v14, MIN(v9) as v26 from aggJoin6613624218123187488 group by v14;
create or replace view aggJoin7047667533208796067 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView371925758220044787 where t.id=aggView371925758220044787.v14 and production_year>2005;
create or replace view aggView6140371801782212504 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7047667533208796067 group by v14;
create or replace view aggJoin8072623653586363873 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6140371801782212504 where mk.movie_id=aggView6140371801782212504.v14;
create or replace view aggView5199242318487488542 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6241276068745936903 as select v26, v27 from aggJoin8072623653586363873 join aggView5199242318487488542 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6241276068745936903;
