create or replace view aggView5814688523706675674 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7497752674391212094 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView5814688523706675674 where mi.movie_id=aggView5814688523706675674.v15 and info IN ('USA','America');
create or replace view aggView5502697591414445189 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3379517297133036440 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5502697591414445189 where mc.company_type_id=aggView5502697591414445189.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4593994381722163500 as select v15 from aggJoin3379517297133036440 group by v15;
create or replace view aggJoin7099600481876537723 as select v3, v13, v27 as v27 from aggJoin7497752674391212094 join aggView4593994381722163500 using(v15);
create or replace view aggView1756161352643091418 as select id as v3 from info_type as it;
create or replace view aggJoin6819142775910375538 as select v13, v27 from aggJoin7099600481876537723 join aggView1756161352643091418 using(v3);
select MIN(v27) as v27 from aggJoin6819142775910375538;
