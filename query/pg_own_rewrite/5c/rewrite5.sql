create or replace view aggView6542415441163683744 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1100300572010267858 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6542415441163683744 where mc.company_type_id=aggView6542415441163683744.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView571656559699372750 as select id as v3 from info_type as it;
create or replace view aggJoin6781185503958058407 as select movie_id as v15, info as v13 from movie_info as mi, aggView571656559699372750 where mi.info_type_id=aggView571656559699372750.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView346703564248141697 as select v15 from aggJoin1100300572010267858 group by v15;
create or replace view aggJoin4293748405835271702 as select v15, v13 from aggJoin6781185503958058407 join aggView346703564248141697 using(v15);
create or replace view aggView6794791038285508029 as select v15 from aggJoin4293748405835271702 group by v15;
create or replace view aggJoin1347798819911012211 as select title as v16 from title as t, aggView6794791038285508029 where t.id=aggView6794791038285508029.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin1347798819911012211;
