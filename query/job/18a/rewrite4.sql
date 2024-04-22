create or replace view aggJoin8819342888670858946 as (
with aggView6213782447193766704 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView6213782447193766704 where mi_idx.info_type_id=aggView6213782447193766704.v10);
create or replace view aggView7567402633546084738 as select v20, v31 from aggJoin8819342888670858946 group by v20,v31;
create or replace view aggJoin4488957979989507080 as (
with aggView6380166595097320935 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView6380166595097320935 where ci.person_id=aggView6380166595097320935.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin4955854397727858009 as (
with aggView4554980749481639668 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView4554980749481639668 where mi.info_type_id=aggView4554980749481639668.v8);
create or replace view aggView6193188188905733345 as select v15, v31 from aggJoin4955854397727858009 group by v15,v31;
create or replace view aggJoin7950721265417076421 as (
with aggView3654390517500836271 as (select v31 from aggJoin4488957979989507080 group by v31)
select id as v31, title as v32 from title as t, aggView3654390517500836271 where t.id=aggView3654390517500836271.v31);
create or replace view aggView8965118588872727897 as select v31, v32 from aggJoin7950721265417076421 group by v31,v32;
create or replace view aggJoin7027783007997700629 as (
with aggView7849371151564129417 as (select v31, MIN(v15) as v43 from aggView6193188188905733345 group by v31)
select v31, v32, v43 from aggView8965118588872727897 join aggView7849371151564129417 using(v31));
create or replace view aggJoin8693735134731688284 as (
with aggView6376869920732185284 as (select v31, MIN(v43) as v43, MIN(v32) as v45 from aggJoin7027783007997700629 group by v31,v43)
select v20, v43, v45 from aggView7567402633546084738 join aggView6376869920732185284 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin8693735134731688284;
