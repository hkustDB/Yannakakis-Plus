create or replace view aggJoin5070057672847181863 as (
with aggView4139202290358874615 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView4139202290358874615 where ci.person_id=aggView4139202290358874615.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7832965237412726912 as (
with aggView8332761464608869720 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView8332761464608869720 where mi.info_type_id=aggView8332761464608869720.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin4421680037757739604 as (
with aggView5189883453606908561 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView5189883453606908561 where mi_idx.info_type_id=aggView5189883453606908561.v10);
create or replace view aggJoin2159071104365818607 as (
with aggView7175873998088671991 as (select v31, MIN(v20) as v44 from aggJoin4421680037757739604 group by v31)
select id as v31, title as v32, v44 from title as t, aggView7175873998088671991 where t.id=aggView7175873998088671991.v31);
create or replace view aggJoin8808097095157450123 as (
with aggView3665409863281399501 as (select v31 from aggJoin5070057672847181863 group by v31)
select v31, v15 from aggJoin7832965237412726912 join aggView3665409863281399501 using(v31));
create or replace view aggJoin8431507551776008196 as (
with aggView3128946665186235615 as (select v31, MIN(v15) as v43 from aggJoin8808097095157450123 group by v31)
select v32, v44 as v44, v43 from aggJoin2159071104365818607 join aggView3128946665186235615 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin8431507551776008196;
