create or replace view aggView3734146556024627905 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6603291437428355080 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView3734146556024627905 where mc.movie_id=aggView3734146556024627905.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView8666959337309012442 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1688381008061466931 as select v15, v9, v27 from aggJoin6603291437428355080 join aggView8666959337309012442 using(v1);
create or replace view aggView3157461173249579306 as select v15, MIN(v27) as v27 from aggJoin1688381008061466931 group by v15;
create or replace view aggJoin4594038401840309457 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3157461173249579306 where mi.movie_id=aggView3157461173249579306.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2223736361655199698 as select v3, MIN(v27) as v27 from aggJoin4594038401840309457 group by v3;
create or replace view aggJoin6311706649953601241 as select v27 from info_type as it, aggView2223736361655199698 where it.id=aggView2223736361655199698.v3;
select MIN(v27) as v27 from aggJoin6311706649953601241;
